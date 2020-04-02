import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_youtube_search/model/details/details_model.dart';
import 'package:flutter_youtube_search/model/network/youtube_data_source.dart';
import 'package:flutter_youtube_search/model/repository/youtube_repository.dart';
import 'package:flutter_youtube_search/model/search/youtube_search_result.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

class MockYoutubeDataSource extends Mock implements YoutubeDataSource {}

void main() {

  String fixture(String name) =>
      File('test/db/$name.json').readAsStringSync();

  YoutubeRepository repository;
  MockYoutubeDataSource mockYoutubeDataSource;

  setUp(() {
    mockYoutubeDataSource = MockYoutubeDataSource();
    repository = YoutubeRepository(mockYoutubeDataSource);
  });

/*
  ->searchResult
  ->noNextPageSearchResult
  ->emptySearchResult
*/
  group('Search', () {
    YoutubeSearchResult searchResult;
    YoutubeSearchResult noNextPageSearchResult;
    YoutubeSearchResult emptySearchResult;

    setUp(() {
      searchResult = YoutubeSearchResult.fromJson(
        fixture('search_result'),
      );

      noNextPageSearchResult = YoutubeSearchResult.fromJson(
        fixture('search_result_no_next_page'),
      );

      emptySearchResult = YoutubeSearchResult.fromJson(
        fixture('search_result_empty'),
      );
    });

    group('searchVideos', () {
      test('returns a list<Searchitems>', () async {
        when(
          mockYoutubeDataSource.searchVideos(
            query: anyNamed('query'),
            pageToken: anyNamed('pageToken'),
          ),
        ).thenAnswer((_) async => searchResult);

        //this method return List<items>
        final searchResultList = await repository.searchVideos('divine');

        expect(searchResultList, searchResult.items);

        verify(mockYoutubeDataSource.searchVideos(
          query: argThat(equals('divine'), named: 'query'),
          pageToken: argThat(equals(''), named: 'pageToken'),
        ));
      });

      test(
          'throws a noSearchResultsException when  calling with an unknown query string',
          () {
        when(mockYoutubeDataSource.searchVideos(
          query: anyNamed('query'),
          pageToken: anyNamed('pageToken'),
        )).thenAnswer(
          (_) async => emptySearchResult,
        );

        expect(() => repository.searchVideos('aldskjflsdlkjfsa'),
            throwsA(TypeMatcher<NoSearchResultsException>()));
      });
    }); //end group test

    group('fetchNextResultPage', () {
      test(
          'throws a SearchNotInitiatedException when called without previously calling searchVideos',
          () {
        expect(() => repository.fetchNextResultPage(),
            throwsA(TypeMatcher<SearchNotInitiatedException>()));

        verifyNever(mockYoutubeDataSource.searchVideos(
          query: anyNamed('query'),
          pageToken: anyNamed('pageToken'),
        ));
      });

      test(
          'returns a List<SearchItem> containing the results form the next page when called after call SearchVideos',
          () async {
        when(mockYoutubeDataSource.searchVideos(
          query: anyNamed('query'),
          pageToken: anyNamed('pageToken'),
        )).thenAnswer(
          (_) async => searchResult,
        );
        await repository.searchVideos('divine');
        final nextPageList = await repository.fetchNextResultPage();

        expect(nextPageList, searchResult.items);
        verifyInOrder([
          mockYoutubeDataSource.searchVideos(
            query: argThat(equals('divine'), named: 'query'),
            pageToken: argThat(equals(''), named: 'pageToken'),
          ),
          mockYoutubeDataSource.searchVideos(
            query: argThat(equals('divine'), named: 'query'),
            pageToken:
                argThat(equals(searchResult.nextPageToken), named: 'pageToken'),
          )
        ]);
      });

      test(
          'throws a noNextPageTokenException when called if we are at the end of the list (hance no next page)',
          () async {
        when(mockYoutubeDataSource.searchVideos(
          query: anyNamed('query'),
          pageToken: anyNamed('pageToken'),
        )).thenAnswer(
          (_) async => noNextPageSearchResult,
        );
        await repository.searchVideos('divine');

        expect(() => repository.fetchNextResultPage(),
            throwsA(TypeMatcher<NoNextPageTokenException>()));
        verifyNever(mockYoutubeDataSource.searchVideos(
          query: anyNamed('query'),
          pageToken: argThat(
              isNot(
                equals(''),
              ),
              named: 'pageToken'),
        ));
      });
    }); //end group
  });


  group('details', (){

    YoutubeVideoResponse videoResponse;
    YoutubeVideoResponse emptyResponse;
    
    
    
    setUp((){
      videoResponse=YoutubeVideoResponse.fromJson(fixture('video_response'));
      emptyResponse=YoutubeVideoResponse.fromJson(fixture('video_response_empty'));
    });
    
    group('fetchVideoInfo', (){


      test('return VideoItems when call successful', ()async{

        when(mockYoutubeDataSource.fetchVideosDetails(id: anyNamed('id')))
            .thenAnswer((_) async => videoResponse);


       final videoItems= await repository.fetchVideoDetails(id: '9emx__jxcTE');
        
       expect(videoItems, videoResponse.items[0]);

       verify(mockYoutubeDataSource.fetchVideosDetails(id: '9emx__jxcTE')).called(1);


      });

    test('throws NoSuchVideoException', (){

      when(mockYoutubeDataSource.fetchVideosDetails(id: anyNamed('id')))
          .thenAnswer((_) async => emptyResponse);
      
      

      
      expect(() => repository.fetchVideoDetails(id: 'abc'), throwsA(TypeMatcher<NoSuchVideoException>()));
      
      


    });

    });


  });
}