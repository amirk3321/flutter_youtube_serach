import 'package:flutter_youtube_search/model/details/details_model.dart';
import 'package:flutter_youtube_search/model/network/api_key.dart';
import 'package:flutter_youtube_search/model/network/youtube_data_source.dart';
import 'package:flutter_youtube_search/model/search/youtube_search_error.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_youtube_search/model/search/youtube_search_result.dart';
import 'dart:io';

class MockClint extends Mock implements http.Client {}

void main() {
  String fixture(String name) => File('test/db/$name.json').readAsStringSync();

  MockClint mockClint;
  YoutubeDataSource youtubeDataSource;

  setUp(() {
    mockClint = MockClint();
    youtubeDataSource = YoutubeDataSource(mockClint);
  });
  group("searchVideos", () {
    test("returns YoutubeSearchResult when the call completes successfully",
        () async {
      when(
        mockClint.get(
          argThat(startsWith('https://www.googleapis.com/youtube/v3/search')),
        ),
      ).thenAnswer(
        (_) async => http.Response(
              fixture("search_result"),
              200,
              headers: {'content-type': 'application/json; charset=UTF-8'},
            ),
      );
      YoutubeSearchResult result = await youtubeDataSource.searchVideos(
          query: 'divine', pageToken: 'CAIQAA');
      expect(result, TypeMatcher<YoutubeSearchResult>());
      expect(result.items.length, 2);
      expect(result.items[0].snippet.title, startsWith('#DIVINE GULLY LIFE'));
    });

    test('throws an error on bad request', () async {
      when(
        mockClint.get(
          argThat(startsWith('https://www.googleapis.com/youtube/v3/search')),
        ),
      ).thenAnswer(
        (_) async => http.Response(
              fixture('error'),
              400,
            ),
      );
      expect(
          () => youtubeDataSource.searchVideos(
                query: 'divine',
                pageToken: 'CAIQAA',
              ),
          throwsA(TypeMatcher<YoutubeSearchError>()));
    });

    test('makes an HTTP request to proper URL', () async {
      when(
        mockClint.get(argThat(
          startsWith('https://www.googleapis.com/youtube/v3/search'),
        )),
      ).thenAnswer(
        (_) async => http.Response(fixture('search_result'), 200, headers: {
              'content-type': 'application/json; charset=UTF-8',
            }),
      );

      youtubeDataSource.searchVideos(query: 'divine');
      youtubeDataSource.searchVideos(query: 'divine', pageToken: 'CAIQAA');
      youtubeDataSource.searchVideos(query: 'kabotar hai');

      verifyInOrder([
        mockClint.get(argThat(
          allOf(
            startsWith('https://www.googleapis.com/youtube/v3/search'),
            contains('part=snippet'),
            contains('maxResults=5'),
            contains('q=divine'),
            contains('type=video'),
            contains('key=$API_KEY'),
            isNot(contains('pageToken')),
          ),
        )),
        mockClint.get(argThat(
          allOf(
            startsWith('https://www.googleapis.com/youtube/v3/search'),
            contains('q=divine'),
            contains('pageToken=CAIQAA'),
          ),
        )),
        mockClint.get(argThat(
          allOf(
            startsWith('https://www.googleapis.com/youtube/v3/search'),
            contains('q=kabotar%20hai'),
          ),
        ))
      ]);
    });
  });

  group('fetchVideoDetails', () {
    test('returns YoutubeVideoResponse when call successful ', () async {
      when(mockClint
              .get(startsWith('https://www.googleapis.com/youtube/v3/videos')))
          .thenAnswer((_) async => http.Response(
                fixture('video_response'),
                200,
                headers: {'content-type': 'application/json; charset=UTF-8'},
              ));

      YoutubeVideoResponse response =
          await youtubeDataSource.fetchVideosDetails(id: '9emx__jxcTE');

      expect(response, TypeMatcher<YoutubeVideoResponse>());
      expect(response.items.length, 1);
      expect(response.items[0].id, '9emx__jxcTE');
    });

    test('throws YoutubeVideoError on a bad request', () {
      when(mockClint
              .get(startsWith('https://www.googleapis.com/youtube/v3/videos')))
          .thenAnswer((_) async => http.Response(
                fixture('error'),
                400,
              ));

      expect(youtubeDataSource.fetchVideosDetails(id: 'abc'),
          throwsA(TypeMatcher<YoutubeVideoError>()));
    });

    test('make http requests to proper URLs,', () {
      when(mockClint
              .get(startsWith('https://www.googleapis.com/youtube/v3/videos')))
          .thenAnswer((_) async => http.Response(
                fixture('video_response'),
                200,
                headers: {'content-type': 'application/json; charset=UTF-8'},
              ));

      youtubeDataSource.fetchVideosDetails(id: 'abc');
      youtubeDataSource.fetchVideosDetails(id: 'fgh');

      verifyInOrder([
        mockClint.get(argThat(allOf(
          startsWith('https://www.googleapis.com/youtube/v3/videos'),
          contains('id=abc'),
          contains('key=$API_KEY'),
        ))),
        mockClint.get(
          argThat(allOf(
            startsWith('https://www.googleapis.com/youtube/v3/videos'),
            contains('id=fgh'),
            contains('key=$API_KEY'),
          ),),
        )
      ]);


    });
  });
}

/*
http.Request
  -> search
  -> http ok = 200, success searchListResultOk
  -> http 404 failure searchListResultFailure
  -> search result empty
  -> search query invalid
  -> nextPageToken null
  ->


 */
