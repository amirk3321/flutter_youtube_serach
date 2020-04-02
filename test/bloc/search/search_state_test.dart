import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_youtube_search/bloc/search/bloc.dart';
import 'package:flutter_youtube_search/model/search/search_model.dart';

void main() {

  group('seachState custom getter', () {
    SearchState initial;
    SearchState loading;
    SearchState success;
    SearchState failure;

    String fixture(String name) =>
        File('test/db/$name.json').readAsStringSync();

    setUp(() {
      final searchResultList =
          YoutubeSearchResult.fromJson(fixture('search_result')).items;

      initial = SearchState.initial();
      loading = SearchState.loading();
      success = SearchState.success(searchResultList);
      failure = SearchState.failure('test message');
    });

    test('isInitial returns true only when instantiated with initial factory',
        () {
      expect(initial.isInitial, true);
      expect(loading.isInitial, false);
      expect(success.isInitial, false);
      expect(failure.isInitial, false);
    });

    test(
        "isSuccessful returns ture only when instantiated with success factory",
        () {
          expect(initial.isSuccess, false);
          expect(loading.isSuccess, false);
          expect(success.isSuccess, true);
          expect(failure.isSuccess, false);
        });
  });
}
