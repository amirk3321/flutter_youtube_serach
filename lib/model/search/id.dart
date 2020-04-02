library id;

import 'dart:convert';
import 'package:build_daemon/data/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'id.g.dart';
abstract class Id  implements Built<Id,IdBuilder>{
    String get videoId;

     Id._();
  factory Id([updates(IdBuilder b)]) = _$Id;

  static Serializer<Id> get serializer => _$idSerializer;
   String toJson(){
    return json.encode(serializers.serializeWith(Id.serializer,this));
  }
  static Id fromJson(String jsonString){
    return serializers.deserializeWith(Id.serializer,json.decode(jsonString));
  }

}