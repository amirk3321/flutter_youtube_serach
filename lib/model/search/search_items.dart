library search_items;

import 'dart:convert';
import 'package:build_daemon/data/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_youtube_search/model/search/search_snippet.dart';

import 'package:flutter_youtube_search/model/search/id.dart';

part 'search_items.g.dart';
abstract class SearchItems  implements Built<SearchItems,SearchItemsBuilder>{
    Id get id;
    SearchSnippet get snippet;

     SearchItems._();
  factory SearchItems([updates(SearchItemsBuilder b)]) = _$SearchItems;

  static Serializer<SearchItems> get serializer => _$searchItemsSerializer;
   String toJson(){
    return json.encode(serializers.serializeWith(SearchItems.serializer,this));
  }
  static SearchItems fromJson(String jsonString){
    return serializers.deserializeWith(SearchItems.serializer,json.decode(jsonString));
  }

}