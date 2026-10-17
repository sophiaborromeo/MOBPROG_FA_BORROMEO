import 'package:flutter/material.dart';
import 'profileinformation.dart';

const double cardHeight = 250;
const double cardWidth = 600;
const double cardRadius = 30;
const Color firstColor = Color.fromARGB(255, 214, 112, 235);
const Color secondColor = Color.fromARGB(255, 80, 80, 220);

class ProfileCard extends StatelessWidget {
  final String name;
  final String course;
  final String motto;
  const ProfileCard({ super.key, required this.name, required this.course, required this.motto, });
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardRadius),
      ),
      child: Container(
        height: cardHeight,
        width: cardWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cardRadius),
          gradient: const LinearGradient(colors: [firstColor, secondColor]),
        ),
        child: Profileinformation(name: name, course: course, motto: motto),
      ),
    );
  }
}
