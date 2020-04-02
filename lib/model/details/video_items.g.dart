// GENERATED CODE - DO NOT MODIFY BY HAND

part of video_items;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<VideoItems> _$videoItemsSerializer = new _$VideoItemsSerializer();

class _$VideoItemsSerializer implements StructuredSerializer<VideoItems> {
  @override
  final Iterable<Type> types = const [VideoItems, _$VideoItems];
  @override
  final String wireName = 'VideoItems';

  @override
  Iterable<Object> serialize(Serializers serializers, VideoItems object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'snippet',
      serializers.serialize(object.snippet,
          specifiedType: const FullType(VideoSnippet)),
    ];

    return result;
  }

  @override
  VideoItems deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VideoItemsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'snippet':
          result.snippet.replace(serializers.deserialize(value,
              specifiedType: const FullType(VideoSnippet)) as VideoSnippet);
          break;
      }
    }

    return result.build();
  }
}

class _$VideoItems extends VideoItems {
  @override
  final String id;
  @override
  final VideoSnippet snippet;

  factory _$VideoItems([void Function(VideoItemsBuilder) updates]) =>
      (new VideoItemsBuilder()..update(updates)).build();

  _$VideoItems._({this.id, this.snippet}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('VideoItems', 'id');
    }
    if (snippet == null) {
      throw new BuiltValueNullFieldError('VideoItems', 'snippet');
    }
  }

  @override
  VideoItems rebuild(void Function(VideoItemsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VideoItemsBuilder toBuilder() => new VideoItemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VideoItems && id == other.id && snippet == other.snippet;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), snippet.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('VideoItems')
          ..add('id', id)
          ..add('snippet', snippet))
        .toString();
  }
}

class VideoItemsBuilder implements Builder<VideoItems, VideoItemsBuilder> {
  _$VideoItems _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  VideoSnippetBuilder _snippet;
  VideoSnippetBuilder get snippet =>
      _$this._snippet ??= new VideoSnippetBuilder();
  set snippet(VideoSnippetBuilder snippet) => _$this._snippet = snippet;

  VideoItemsBuilder();

  VideoItemsBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _snippet = _$v.snippet?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VideoItems other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$VideoItems;
  }

  @override
  void update(void Function(VideoItemsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$VideoItems build() {
    _$VideoItems _$result;
    try {
      _$result = _$v ?? new _$VideoItems._(id: id, snippet: snippet.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'snippet';
        snippet.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'VideoItems', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
