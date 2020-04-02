import 'package:kiwi/kiwi.dart' as Kiwi;
import 'package:http/http.dart' as http;
import 'package:flutter_youtube_search/model/network/youtube_data_source.dart';
import 'package:flutter_youtube_search/model/repository/youtube_repository.dart';
import 'package:flutter_youtube_search/bloc/search/bloc.dart';
import 'package:flutter_youtube_search/bloc/details/bloc.dart';


void initKiwi(){
  Kiwi.Container()..registerInstance(http.Client())
      ..registerFactory((c) => YoutubeDataSource(c.resolve()))
      ..registerFactory((c) => YoutubeRepository(c.resolve()))
      ..registerFactory((c) => SearchBloc(c.resolve()))
      ..registerFactory((c) => DetailsBloc(c.resolve()));
}