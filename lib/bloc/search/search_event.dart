library search_event;

import 'package:meta/meta.dart';

import 'dart:convert';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';


part 'search_event.g.dart';


abstract class SearchEvent {}

abstract class SearchInitiated extends SearchEvent
    implements Built<SearchInitiated,SearchInitiatedBuilder>{
    String get query;

     SearchInitiated._();
  factory SearchInitiated([updates(SearchInitiatedBuilder b)]) = _$SearchInitiated;


  @override
  String toString() => "SearchInitiated $query";
}

class FetchNextPageResult extends SearchEvent{
  @override
  String toString() => "FetchNextPageResult";
}