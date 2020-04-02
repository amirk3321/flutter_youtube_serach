// GENERATED CODE - DO NOT MODIFY BY HAND

part of details_event;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FetchVideoInfo extends FetchVideoInfo {
  @override
  final String id;

  factory _$FetchVideoInfo([void Function(FetchVideoInfoBuilder) updates]) =>
      (new FetchVideoInfoBuilder()..update(updates)).build();

  _$FetchVideoInfo._({this.id}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('FetchVideoInfo', 'id');
    }
  }

  @override
  FetchVideoInfo rebuild(void Function(FetchVideoInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FetchVideoInfoBuilder toBuilder() =>
      new FetchVideoInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FetchVideoInfo && id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(0, id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FetchVideoInfo')..add('id', id))
        .toString();
  }
}

class FetchVideoInfoBuilder
    implements Builder<FetchVideoInfo, FetchVideoInfoBuilder> {
  _$FetchVideoInfo _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  FetchVideoInfoBuilder();

  FetchVideoInfoBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FetchVideoInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FetchVideoInfo;
  }

  @override
  void update(void Function(FetchVideoInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FetchVideoInfo build() {
    final _$result = _$v ?? new _$FetchVideoInfo._(id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
