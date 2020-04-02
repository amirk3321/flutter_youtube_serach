import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:flutter_youtube_search/bloc/search/bloc.dart';
import 'package:flutter_youtube_search/model/repository/youtube_repository.dart';
import 'package:flutter_youtube_search/model/search/search_items.dart';
import 'package:flutter_youtube_search/model/search/search_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_youtube_search/model/search/youtube_search_error.dart';

class MockYoutubeRepository extends Mock implements YoutubeRepository {}

void main() {
  SearchBloc searchBloc;
  MockYoutubeRepository mockYoutubeRepository;

  String fixture(String name) => File('test/db/$name.json').readAsStringSync();

  setUp(() {
    mockYoutubeRepository = MockYoutubeRepository();
    searchBloc = SearchBloc(mockYoutubeRepository);
  });

  test('initial state is correct', () {
    expect(searchBloc.initialState, SearchState.initial());
  });

  group('SearchInitiated', () {
    BuiltList<SearchItems> searchResultList;

    setUp(() {
      searchResultList =
          YoutubeSearchResult.fromJson(fixture('search_result')).items;

      when(
        mockYoutubeRepository.searchVideos(any),
      ).thenAnswer((_) async => searchResultList);
    });

    test('emits [nothing] (only initial state) for an empty search string', () {
      final expectedResponse = [SearchState.initial()];

      expectLater(searchBloc.state, emitsInOrder(expectedResponse));

      searchBloc.onSearchInitiated('');

      verifyNever(mockYoutubeRepository.searchVideos(any));
    });

    test('emits [loading , success]', () async {
      final expectedResponse = [
        SearchState.initial(),
        SearchState.loading(),
        SearchState.success(searchResultList),
      ];

      expectLater(searchBloc.state, emitsInOrder(expectedResponse));

      searchBloc.onSearchInitiated('divine');

      await untilCalled(mockYoutubeRepository.searchVideos(any));

      verify(mockYoutubeRepository.searchVideos(argThat(equals('divine'))));
    }); //snd test

    test(
        'emits [loading, success, initial] for search string which is first valid query and then empty',
        () async {
      final expectedResponse = [
        SearchState.initial(),
        SearchState.loading(),
        SearchState.success(searchResultList),
        SearchState.initial(),
      ];

      expectLater(searchBloc.state, emitsInOrder(expectedResponse));

      searchBloc.onSearchInitiated('divine');
      searchBloc.onSearchInitiated('');

      await untilCalled(
          mockYoutubeRepository.searchVideos(argThat(equals('divine'))));

      verify(mockYoutubeRepository.searchVideos(argThat(equals('divine'))))
          .called(1);
    });
//
    test('emits [loading, failure] when repository throws a youtubeSearchError',
        () async {
      reset(mockYoutubeRepository);

      when(mockYoutubeRepository.searchVideos(any))
          .thenThrow(YoutubeSearchError('test Message'));

      final expectedResponse = [
        SearchState.initial(),
        SearchState.loading(),
        SearchState.failure('test Message'),
      ];
      
      expectLater(searchBloc.state, emitsInOrder(expectedResponse));

      searchBloc.onSearchInitiated('divine');

      await untilCalled(mockYoutubeRepository.searchVideos(any));

      verify(mockYoutubeRepository.searchVideos(argThat(equals('divine')))).called(1);
    });

    test(
        'emits [loading, failure] when repository throws a NoSearchResultException',
        () async {
      reset(mockYoutubeRepository);
      when(
        mockYoutubeRepository.searchVideos(any),
      ).thenThrow(NoSearchResultsException());

      final expectedResponse = [
        SearchState.initial(),
        SearchState.loading(),
        SearchState.failure(NoSearchResultsException().message),
      ];

      expectLater(searchBloc.state, emitsInOrder(expectedResponse));

      searchBloc.onSearchInitiated('sslksdjfslkdjfslkjfsdlk');

      await untilCalled(mockYoutubeRepository.searchVideos(any));

      verify(mockYoutubeRepository
              .searchVideos(argThat(equals('sslksdjfslkdjfslkjfsdlk')),
      )).called(1);
    });
  });

  group('fetchNextPageResult', () {
    BuiltList<SearchItems> searchResultList;

    setUp(() {
      searchResultList =
          YoutubeSearchResult.fromJson(fixture('search_result')).items;
    });

    test('emits [initial success] if fetchNextPageResult call is successful',
            () async {
          when(mockYoutubeRepository.fetchNextResultPage())
              .thenAnswer((_) async => searchResultList);

          final expectedResponse = [
            SearchState.initial(),
            SearchState.success(searchResultList),
          ];
          expectLater(
            searchBloc.state,
            emitsInOrder(expectedResponse),
          );

          searchBloc.onFetchNextPageResult();

          await untilCalled(mockYoutubeRepository.fetchNextResultPage());

          verify(mockYoutubeRepository.fetchNextResultPage()).called(1);
        });

    test(
        'emits [failure] if fetchNextPageResult is called before the search has begun',
            () async {
          when(mockYoutubeRepository.fetchNextResultPage())
              .thenThrow(SearchNotInitiatedException());

          final expectedResponse = [
            SearchState.initial(),
            SearchState.failure(SearchNotInitiatedException().message)
          ];

          expectLater(searchBloc.state, emitsInOrder(expectedResponse));

          searchBloc.onFetchNextPageResult();

          await untilCalled(mockYoutubeRepository.fetchNextResultPage());

          verify(mockYoutubeRepository.fetchNextResultPage()).called(1);
        });


    test(
        'emits currentState with hasReachedEndOfResult == true when no more results are present',
            () async {
          when(mockYoutubeRepository.fetchNextResultPage())
              .thenThrow(NoNextPageTokenException());

          final expectedResponse = [
            SearchState.initial(),
            SearchState.initial().rebuild((b) => b..hasReachedEndOfResults = true)
          ];

          expectLater(searchBloc.state, emitsInOrder(expectedResponse));

          searchBloc.onFetchNextPageResult();

          await untilCalled(mockYoutubeRepository.fetchNextResultPage());

          verify(mockYoutubeRepository.fetchNextResultPage()).called(1);
        });

    test('emits [failure] when repository throws a YoutubeSearchError',
            () async {
          when(mockYoutubeRepository.fetchNextResultPage()
          ).thenThrow(YoutubeSearchError('test message'));

          final expectedResponse = [
            SearchState.initial(),
            SearchState.failure('test message'),
          ];


          expectLater(searchBloc.state, emitsInOrder(expectedResponse));

          searchBloc.onFetchNextPageResult();

          await untilCalled(mockYoutubeRepository.fetchNextResultPage());

          verify(mockYoutubeRepository.fetchNextResultPage()).called(1);
        });
  });



}