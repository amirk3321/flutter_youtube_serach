import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:flutter_youtube_search/model/repository/youtube_repository.dart';
import 'package:flutter_youtube_search/model/details/youtube_video_error.dart';


class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final YoutubeRepository _repository;

  void onFetchVideoDetails({String id}) {
    dispatch(
      FetchVideoInfo((b) => b..id = id),
    );
  }

  DetailsBloc(this._repository);

  @override
  DetailsState get initialState => DetailsState.initial();

  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    if (event is FetchVideoInfo){
      yield DetailsState.loading();
      try{

        final items = await _repository.fetchVideoDetails(id: event.id);

        yield DetailsState.success(items);

      } on YoutubeVideoError catch(e){
        yield DetailsState.failure(e.message);
      } on NoSuchVideoException catch(e){
        yield DetailsState.failure(e.message);
      }
    }
  }
}
