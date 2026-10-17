import 'package:flutter/material.dart';
import 'main.dart';
import 'carddesign.dart';

const double large= 40;
const double medium= 20;
const double small= 12;
const double spacing= 15;
const Color color = Colors.white;

class Profileinformation extends StatelessWidget {
  final String name; 
  final String course; 
  final String motto; 
  
  const Profileinformation({ super.key, required this.name, required this.course, required this.motto, });

    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              height: 250,
              width: 600,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [firstColor,secondColor,],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: large,
                    ),
                  ),

                  SizedBox(height: spacing),

                  Text(
                    course,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: color,
                      fontSize: medium,
                    ),
                  ),

                  SizedBox(height: spacing),

                  Text(
                    motto,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: color,
                      fontStyle: FontStyle.italic,
                      fontSize: small,
                    ),
                  ),
                ],
              ),
          ),
          ),
        ),
        ),
        debugShowCheckedModeBanner: false, 
    );
  }
}