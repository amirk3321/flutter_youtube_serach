library thumbnails;

import 'dart:convert';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_youtube_search/model/common/thumbnail.dart';
import 'package:flutter_youtube_search/model/serializer/serializers.dart';

part 'thumbnails.g.dart';

abstract class Thumbnails implements Built<Thumbnails, ThumbnailsBuilder> {
  @BuiltValueField(wireName: 'default')
  Thumbnail get default_;

  Thumbnail get medium;

  Thumbnail get high;

  Thumbnails._();

  factory Thumbnails([updates(ThumbnailsBuilder b)]) = _$Thumbnails;

  static Serializer<Thumbnails> get serializer => _$thumbnailsSerializer;

  String toJson() {
    return json.encode(serializers.serializeWith(Thumbnails.serializer, this));
  }

  static Thumbnails fromJson(String jsonString) {
    return serializers.deserializeWith(
        Thumbnails.serializer, json.decode(jsonString));
  }
}
