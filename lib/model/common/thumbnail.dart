library thumbnail;

import 'dart:convert';
import 'package:build_daemon/data/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'thumbnail.g.dart';

abstract class Thumbnail implements Built<Thumbnail, ThumbnailBuilder> {
  String get url;

  int get width;

  int get height;

  Thumbnail._();

  factory Thumbnail([updates(ThumbnailBuilder b)]) = _$Thumbnail;

  static Serializer<Thumbnail> get serializer => _$thumbnailSerializer;

  String toJson() {
    return json.encode(serializers.serializeWith(Thumbnail.serializer, this));
  }

  static Thumbnail fromJson(String jsonString) {
    return serializers.deserializeWith(
        Thumbnail.serializer, json.decode(jsonString));
  }
}
