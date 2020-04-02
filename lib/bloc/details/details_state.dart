library details_state;

import 'package:built_value/built_value.dart';
import 'package:flutter_youtube_search/model/details/details_model.dart';

part 'details_state.g.dart';

abstract class DetailsState
    implements Built<DetailsState, DetailsStateBuilder> {
  bool get isLoading;

  String get error;

  @nullable
  VideoItems get videoItems;

  bool get isInitial =>
      !isLoading && videoItems == null && error == '';

  bool get isSuccess =>
      !isLoading && videoItems != null && error == '';

  DetailsState._();

  factory DetailsState([updates(DetailsStateBuilder b)]) = _$DetailsState;

  //initial
  //loading
  //success
  //Failure

  factory DetailsState.initial() {
    return DetailsState((b) => b
      ..isLoading = false
      ..videoItems = null
      ..error = '');
  }

  factory DetailsState.loading() {
    return DetailsState((b) => b
      ..isLoading = true
      ..videoItems = null
      ..error = '');
  }

  factory DetailsState.success(VideoItems items) {
    return DetailsState((b) => b
      ..isLoading = false
      ..videoItems.replace(items)
      ..error = '');
  }

  factory DetailsState.failure(String error) {
    return DetailsState((b) => b
      ..isLoading = false
      ..videoItems = null
      ..error = error);
  }
}
