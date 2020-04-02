library video_snippet;

import 'dart:convert';
import 'package:build_daemon/data/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_youtube_search/model/common/thumbnails.dart';

part 'video_snippet.g.dart';
abstract class VideoSnippet  implements Built<VideoSnippet,VideoSnippetBuilder>{

    String get publishedAt;
    String get channelId;
    String get title;
    String get description;
    Thumbnails get thumbnails;
    BuiltList<String> get tags;

     VideoSnippet._();
  factory VideoSnippet([updates(VideoSnippetBuilder b)]) = _$VideoSnippet;

  static Serializer<VideoSnippet> get serializer => _$videoSnippetSerializer;
   String toJson(){
    return json.encode(serializers.serializeWith(VideoSnippet.serializer,this));
  }
  static VideoSnippet fromJson(String jsonString){
    return serializers.deserializeWith(VideoSnippet.serializer,json.decode(jsonString));
  }

}