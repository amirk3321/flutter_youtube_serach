library search_state;


import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_youtube_search/model/search/search_items.dart';

part 'search_state.g.dart';

abstract class SearchState implements Built<SearchState, SearchStateBuilder> {
  bool get isLoading;

  BuiltList<SearchItems> get searchResult;

  String get error;

  bool get hasReachedEndOfResults;

  bool get isInitial =>
      !isLoading && searchResult.isEmpty && error == '';

  bool get isSuccess =>
      !isLoading && searchResult.isNotEmpty && error == '';


  SearchState._();

  factory SearchState([updates(SearchStateBuilder b)]) = _$SearchState;

  factory SearchState.initial() {
    return SearchState((b) => b
      ..isLoading = false
      ..searchResult.replace(BuiltList<SearchItems>())
      ..error = ''
      ..hasReachedEndOfResults = false);
  }

  factory SearchState.loading() {
    return SearchState(
      (b) => b
        ..isLoading = true
        ..searchResult.replace(BuiltList<SearchItems>())
        ..error = ''
        ..hasReachedEndOfResults = false,
    );
  }

  factory SearchState.failure(String error) {
    return SearchState((b) => b
      ..isLoading = false
      ..searchResult.replace(BuiltList<SearchItems>())
      ..error = error
      ..hasReachedEndOfResults = false);
  }
  factory SearchState.success(BuiltList<SearchItems> resultList) {
    return SearchState((b) => b
      ..isLoading = false
      ..searchResult.replace(resultList)
      ..error = ''
      ..hasReachedEndOfResults = false);
  }
}
