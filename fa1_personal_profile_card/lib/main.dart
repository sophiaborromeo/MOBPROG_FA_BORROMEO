import 'package:flutter/material.dart';
import 'carddesign.dart';

const Color backgroundColor = Color.fromARGB(255, 113, 11, 122);
final String name= 'Elisha Sophia Borromeo'; 
final String course= 'BS Applied Mathematics with Information Technology'; 
final String motto= 'Mind over matter'; 


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: ProfileCard(
            name: name,
            course: course,
            motto: motto,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false, //learned from previous 4th years hihi :)
    );
  }
}
