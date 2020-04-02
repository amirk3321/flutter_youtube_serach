import 'dart:convert';

import 'package:flutter_youtube_search/model/details/details_model.dart';
import 'package:flutter_youtube_search/model/network/api_key.dart';
import 'package:flutter_youtube_search/model/search/youtube_search_error.dart';
import 'package:flutter_youtube_search/model/search/youtube_search_result.dart';
import 'package:http/http.dart' as http;

const MAX_RESULT = 5;

class YoutubeDataSource {
  final http.Client client;
  final baseUrl = 'https://www.googleapis.com/youtube/v3/search?'
      'part=snippet&maxResults=$MAX_RESULT&type=video&key=$API_KEY';

  final _videoUrl = 'https://www.googleapis.com/youtube/v3/'
      'videos?part=snippet&key=AIzaSyBkqyWGBk1dLsi-cXcn9s1FV7pcPORhl8U';

  YoutubeDataSource(this.client);

  Future<YoutubeSearchResult> searchVideos(
      {String query, String pageToken = ''}) async {
    final rowUrl = baseUrl +
        '&q=$query' +
        (pageToken.isNotEmpty ? '&pageToken=$pageToken' : '');

    final urlEncoded = Uri.encodeFull(rowUrl);
    final response = await client.get(urlEncoded);

    if (response.statusCode == 200) {
      return YoutubeSearchResult.fromJson(response.body);
    } else {
      throw YoutubeSearchError(json.decode(response.body)['error']['message']);
    }
  }

  Future<YoutubeVideoResponse> fetchVideosDetails({String id}) async{
    final url = _videoUrl + '&id=$id';

    final response =await client.get(url);

    if (response.statusCode == 200){
      return YoutubeVideoResponse.fromJson(response.body);
    }else{
      throw YoutubeVideoError(json.decode(response.body)['error']['message']);
    }

  }


}
