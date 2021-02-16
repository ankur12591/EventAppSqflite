import 'package:flutter/material.dart';
import 'package:new_event/screens/new_list2.dart';
import 'package:new_event/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes:{
        '/home':(_) => EventList(),
      },
    );
  }
}
