import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_youtube_search/model/repository/youtube_repository.dart';
import 'package:flutter_youtube_search/bloc/search/bloc.dart';
import 'package:flutter_youtube_search/model/search/youtube_search_error.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final YoutubeRepository _searchRepository;

  SearchBloc(this._searchRepository) : super();

  void onSearchInitiated(String query){
    dispatch(SearchInitiated((b) => b..query =query));
  }

  void onFetchNextPageResult(){
    dispatch(FetchNextPageResult());
  }



  @override
  SearchState get initialState => SearchState.initial();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchInitiated){
      yield* _mapSearchInitiated(event);
    }else if (event is FetchNextPageResult){
      yield* _mapFetchNextPageResult();
    }
  }

 Stream<SearchState> _mapSearchInitiated(SearchInitiated event) async*{
    if (event.query.isEmpty){
      yield SearchState.initial();
    }else{
      yield SearchState.loading();

      try{

        final searchResult= await _searchRepository.searchVideos(event.query);

       yield SearchState.success(searchResult);

      } on YoutubeSearchError catch(e){
        yield SearchState.failure(e.msg);
      } on NoSearchResultsException catch(e){
        yield SearchState.failure(e.message);
      }
    }
 }

 Stream<SearchState> _mapFetchNextPageResult() async*{
    try {
      final nextPageResult = await _searchRepository.fetchNextResultPage();
      yield SearchState.success(currentState.searchResult + nextPageResult);

    } on SearchNotInitiatedException catch (e){
      yield SearchState.failure(e.message);
    } on NoNextPageTokenException catch(_){
      yield currentState.rebuild((b) => b..hasReachedEndOfResults = true);
      print("check result :currentState.hasReachedEndOfResults");
    } on YoutubeSearchError catch(e){
      yield SearchState.failure(e.msg);
    }
 }
}
