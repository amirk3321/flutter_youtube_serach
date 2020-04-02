import 'package:built_collection/built_collection.dart';
import 'package:flutter_youtube_search/model/details/details_model.dart';
import 'package:flutter_youtube_search/model/network/youtube_data_source.dart';
import 'package:flutter_youtube_search/model/search/search_model.dart';

class YoutubeRepository {
  YoutubeDataSource _youtubeDataSource;

  YoutubeRepository(this._youtubeDataSource);

  String _lastSearchQuery;
  String _nextPageToken;
  //divine
  Future<BuiltList<SearchItems>> searchVideos(String query) async {
    final searchResult = await _youtubeDataSource.searchVideos(
      query: query,
    );

    _cacheValues(query: query, nextPageToken: searchResult.nextPageToken);
    if (searchResult.items.isEmpty) throw NoSearchResultsException();

    return searchResult.items;
  }

  void _cacheValues({String query, String nextPageToken}) {
    _lastSearchQuery = query;
    _nextPageToken = nextPageToken;
  }

  Future<BuiltList<SearchItems>> fetchNextResultPage() async {
    if (_lastSearchQuery == null) {
      throw SearchNotInitiatedException();
    }
    if (_nextPageToken == null) {
      throw NoNextPageTokenException();
    }
    final nextPageSearchResult = await _youtubeDataSource.searchVideos(
      query: _lastSearchQuery,
      pageToken: _nextPageToken,
    );
    _cacheValues(
      query: _lastSearchQuery,
      nextPageToken: nextPageSearchResult.nextPageToken,
    );
    return nextPageSearchResult.items;
  }

  Future<VideoItems> fetchVideoDetails({String id}) async{
    final response = await _youtubeDataSource.fetchVideosDetails(id: id);

    if (response.items.isEmpty)
      throw NoSuchVideoException();

    return response.items[0];
  }

}

class NoSearchResultsException implements Exception {
  final message = 'No Result';
}

class SearchNotInitiatedException implements Exception {
  final message = 'can not get the next result page without searching first';
}

class NoNextPageTokenException implements Exception {}


class NoSuchVideoException implements Exception {
  String message ="not Found any Video :(";
}