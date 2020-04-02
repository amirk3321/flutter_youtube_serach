import 'dart:io';

import 'package:flutter_youtube_search/model/details/details_model.dart';
import 'package:flutter_youtube_search/model/repository/youtube_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_youtube_search/bloc/details/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockYoutubeVideoResponse extends Mock implements YoutubeRepository {}

void main() {
  String fixture(String name) => File('test/db/$name.json').readAsStringSync();

  DetailsBloc detailsBloc;
  MockYoutubeVideoResponse mockVideoResponse;

  setUp(() {
    mockVideoResponse = MockYoutubeVideoResponse();
    detailsBloc = DetailsBloc(mockVideoResponse);
  });

  test('test initial state is set DetailsState.Initial', () {
    expect(detailsBloc.initialState, DetailsState.initial());
  });

  group('fetchVideoDetails', () {
    VideoItems videoItems;

    setUp(() {
      videoItems =
          YoutubeVideoResponse.fromJson(fixture('video_response')).items[0];
    });

    test('emits [loading success] for valid video id', () async {
      when(mockVideoResponse.fetchVideoDetails(id: anyNamed('id')))
          .thenAnswer((_) async => videoItems);

      final response = [
        DetailsState.initial(),
        DetailsState.loading(),
        DetailsState.success(videoItems)
      ];

      expectLater(detailsBloc.state, emitsInOrder(response));

      detailsBloc.onFetchVideoDetails(id: '9emx__jxcTE');

      await untilCalled(
          mockVideoResponse.fetchVideoDetails(id: anyNamed('id')));

      verify(mockVideoResponse.fetchVideoDetails(
              id: argThat(equals('9emx__jxcTE'), named: 'id')))
          .called(1);
    });



    test('emits return [loading Failure] when repo throw YoutubeVideoException', () async {

      when(mockVideoResponse.fetchVideoDetails(id: anyNamed('id')))
      .thenThrow(YoutubeVideoError('test message'));


      final response =[
        DetailsState.initial(),
        DetailsState.loading(),
        DetailsState.failure('test message'),
      ];

      expectLater(detailsBloc.state, emitsInOrder(response));

      detailsBloc.onFetchVideoDetails(id: 'abc');

      await untilCalled(mockVideoResponse.fetchVideoDetails(id: anyNamed('id')));

      verify(mockVideoResponse.fetchVideoDetails(id: argThat(equals('abc'),named: 'id')));

    });


    test('emits return [loading,failure] when throw NoSuchVideoException', () async {

      when(mockVideoResponse.fetchVideoDetails(id: anyNamed('id')))
          .thenThrow(NoSuchVideoException());


      final response=[
        DetailsState.initial(),
        DetailsState.loading(),
        DetailsState.failure(NoSuchVideoException().message),
      ];

      expectLater(detailsBloc.state, emitsInOrder(response));

      detailsBloc.onFetchVideoDetails(id: 'abc');

      await untilCalled(mockVideoResponse.fetchVideoDetails(id: anyNamed('id')));


      verify(mockVideoResponse.fetchVideoDetails(id: argThat(equals('abc'),named: 'id')))
      .called(1);


    });


  });


}
