

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_youtube_search/bloc/details/bloc.dart';
import 'package:flutter_youtube_search/model/details/details_model.dart';



void main(){


  group('DetailsState custom getter', (){


    DetailsState isInitial;
    DetailsState isLoading;
    DetailsState isSuccess;
    DetailsState isFailure;



    String fixture(String name) =>
        File('test/db/$name.json').readAsStringSync();

    setUp((){
      final videoResponse=YoutubeVideoResponse.fromJson(fixture('video_response')).items[0];
      isInitial=DetailsState.initial();
      isLoading=DetailsState.loading();
      isSuccess=DetailsState.success(videoResponse);
      isFailure=DetailsState.failure('test message');


    });

    test('isInitial returns true when instantiated initial factory', (){
      
      expect(isInitial.isInitial, true);
      expect(isLoading.isInitial, false);
      expect(isSuccess.isInitial, false);
      expect(isFailure.isInitial, false);
      
    });

    test('isSuccess return true when instantiatd success factory', (){
      expect(isInitial.isSuccess, false);
      expect(isLoading.isSuccess, false);
      expect(isSuccess.isSuccess, true);
      expect(isFailure.isSuccess, false);

    });

  });


}