
library video_items;

import 'dart:convert';
import 'package:build_daemon/data/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_youtube_search/model/details/video_snippet.dart';

part 'video_items.g.dart';

abstract class VideoItems  implements Built<VideoItems,VideoItemsBuilder>{
    //Fields
    String get id;
    VideoSnippet get snippet;


     VideoItems._();
  factory VideoItems([updates(VideoItemsBuilder b)]) = _$VideoItems;

  static Serializer<VideoItems> get serializer => _$videoItemsSerializer;
   String toJson(){
    return json.encode(serializers.serializeWith(VideoItems.serializer,this));
  }
  static VideoItems fromJson(String jsonString){
    return serializers.deserializeWith(VideoItems.serializer,json.decode(jsonString));
  }

}