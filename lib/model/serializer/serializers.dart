library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:flutter_youtube_search/model/common/thumbnail_model.dart';
import 'package:flutter_youtube_search/model/search/search_model.dart';
import 'package:flutter_youtube_search/model/details/details_model.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Id,
  SearchItems,
  SearchSnippet,
  YoutubeSearchResult,
  Thumbnail,
  Thumbnails,
  YoutubeVideoResponse,
  VideoItems,
  VideoSnippet,

])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
