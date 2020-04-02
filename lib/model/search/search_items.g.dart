// GENERATED CODE - DO NOT MODIFY BY HAND

part of search_items;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SearchItems> _$searchItemsSerializer = new _$SearchItemsSerializer();

class _$SearchItemsSerializer implements StructuredSerializer<SearchItems> {
  @override
  final Iterable<Type> types = const [SearchItems, _$SearchItems];
  @override
  final String wireName = 'SearchItems';

  @override
  Iterable<Object> serialize(Serializers serializers, SearchItems object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(Id)),
      'snippet',
      serializers.serialize(object.snippet,
          specifiedType: const FullType(SearchSnippet)),
    ];

    return result;
  }

  @override
  SearchItems deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SearchItemsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id.replace(serializers.deserialize(value,
              specifiedType: const FullType(Id)) as Id);
          break;
        case 'snippet':
          result.snippet.replace(serializers.deserialize(value,
              specifiedType: const FullType(SearchSnippet)) as SearchSnippet);
          break;
      }
    }

    return result.build();
  }
}

class _$SearchItems extends SearchItems {
  @override
  final Id id;
  @override
  final SearchSnippet snippet;

  factory _$SearchItems([void Function(SearchItemsBuilder) updates]) =>
      (new SearchItemsBuilder()..update(updates)).build();

  _$SearchItems._({this.id, this.snippet}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('SearchItems', 'id');
    }
    if (snippet == null) {
      throw new BuiltValueNullFieldError('SearchItems', 'snippet');
    }
  }

  @override
  SearchItems rebuild(void Function(SearchItemsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SearchItemsBuilder toBuilder() => new SearchItemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchItems && id == other.id && snippet == other.snippet;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), snippet.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SearchItems')
          ..add('id', id)
          ..add('snippet', snippet))
        .toString();
  }
}

class SearchItemsBuilder implements Builder<SearchItems, SearchItemsBuilder> {
  _$SearchItems _$v;

  IdBuilder _id;
  IdBuilder get id => _$this._id ??= new IdBuilder();
  set id(IdBuilder id) => _$this._id = id;

  SearchSnippetBuilder _snippet;
  SearchSnippetBuilder get snippet =>
      _$this._snippet ??= new SearchSnippetBuilder();
  set snippet(SearchSnippetBuilder snippet) => _$this._snippet = snippet;

  SearchItemsBuilder();

  SearchItemsBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id?.toBuilder();
      _snippet = _$v.snippet?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchItems other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SearchItems;
  }

  @override
  void update(void Function(SearchItemsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SearchItems build() {
    _$SearchItems _$result;
    try {
      _$result =
          _$v ?? new _$SearchItems._(id: id.build(), snippet: snippet.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'id';
        id.build();
        _$failedField = 'snippet';
        snippet.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SearchItems', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
