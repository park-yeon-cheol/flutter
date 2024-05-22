import 'package:flutter/material.dart';
import 'package:flutter_lab/flutter_app/navigation/thirdPage.dart';
import 'subDetail.dart';
import 'secondDetail.dart';
import 'thirdPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      initialRoute: '/',
      routes: {
        '/': (context) => SubDetail(),
        '/second': (context) => SecondDetail(),
        '/third': (context) => ThirdDetail(),
      },
    );
  }
}