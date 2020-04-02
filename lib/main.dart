
import 'package:flutter/material.dart';
import 'package:flutter_youtube_search/ui/home_page.dart';
import 'package:bloc/bloc.dart';
import 'bloc/delegate/simple_delegate.dart';
import 'injection_container.dart';

void main() {
  BlocSupervisor.delegate=SimpleDelegate();
  initKiwi() ;
  runApp(myApp());
}


class myApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>myAppState();
}

class myAppState extends State<myApp>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Youtube Limited",
      theme: ThemeData(
        accentColor: Colors.red.shade600,
        primaryColor: Colors.red.shade400,
        accentColorBrightness: Brightness.light
      ),
      home: HomePage(),
    );
  }
}