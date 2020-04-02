



library details_event;

import 'dart:convert';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'details_event.g.dart';

abstract class DetailsEvent {}

abstract class FetchVideoInfo extends DetailsEvent implements Built<FetchVideoInfo,FetchVideoInfoBuilder>{
    String get id;

     FetchVideoInfo._();
  factory FetchVideoInfo([updates(FetchVideoInfoBuilder b)]) = _$FetchVideoInfo;

}
