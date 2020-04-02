library youtube_search_result;

import 'dart:convert';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_youtube_search/model/search/search_items.dart';
import 'package:flutter_youtube_search/model/serializer/serializers.dart';

part 'youtube_search_result.g.dart';
abstract class YoutubeSearchResult  implements Built<YoutubeSearchResult,YoutubeSearchResultBuilder>{
  @nullable
  String get nextPageToken;
  BuiltList<SearchItems> get items;

     YoutubeSearchResult._();
  factory YoutubeSearchResult([updates(YoutubeSearchResultBuilder b)]) = _$YoutubeSearchResult;

  static Serializer<YoutubeSearchResult> get serializer => _$youtubeSearchResultSerializer;
   String toJson(){
    return json.encode(serializers.serializeWith(YoutubeSearchResult.serializer,this));
  }
  static YoutubeSearchResult fromJson(String jsonString){
    return serializers.deserializeWith(YoutubeSearchResult.serializer,json.decode(jsonString));
  }

}