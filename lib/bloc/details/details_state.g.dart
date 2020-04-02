// GENERATED CODE - DO NOT MODIFY BY HAND

part of details_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DetailsState extends DetailsState {
  @override
  final bool isLoading;
  @override
  final String error;
  @override
  final VideoItems videoItems;

  factory _$DetailsState([void Function(DetailsStateBuilder) updates]) =>
      (new DetailsStateBuilder()..update(updates)).build();

  _$DetailsState._({this.isLoading, this.error, this.videoItems}) : super._() {
    if (isLoading == null) {
      throw new BuiltValueNullFieldError('DetailsState', 'isLoading');
    }
    if (error == null) {
      throw new BuiltValueNullFieldError('DetailsState', 'error');
    }
  }

  @override
  DetailsState rebuild(void Function(DetailsStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DetailsStateBuilder toBuilder() => new DetailsStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DetailsState &&
        isLoading == other.isLoading &&
        error == other.error &&
        videoItems == other.videoItems;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, isLoading.hashCode), error.hashCode), videoItems.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DetailsState')
          ..add('isLoading', isLoading)
          ..add('error', error)
          ..add('videoItems', videoItems))
        .toString();
  }
}

class DetailsStateBuilder
    implements Builder<DetailsState, DetailsStateBuilder> {
  _$DetailsState _$v;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  String _error;
  String get error => _$this._error;
  set error(String error) => _$this._error = error;

  VideoItemsBuilder _videoItems;
  VideoItemsBuilder get videoItems =>
      _$this._videoItems ??= new VideoItemsBuilder();
  set videoItems(VideoItemsBuilder videoItems) =>
      _$this._videoItems = videoItems;

  DetailsStateBuilder();

  DetailsStateBuilder get _$this {
    if (_$v != null) {
      _isLoading = _$v.isLoading;
      _error = _$v.error;
      _videoItems = _$v.videoItems?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DetailsState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DetailsState;
  }

  @override
  void update(void Function(DetailsStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DetailsState build() {
    _$DetailsState _$result;
    try {
      _$result = _$v ??
          new _$DetailsState._(
              isLoading: isLoading,
              error: error,
              videoItems: _videoItems?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'videoItems';
        _videoItems?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DetailsState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
