import 'package:flutter/material.dart';

class AddPhotoWidget extends StatelessWidget {
  const AddPhotoWidget({
    super.key,
    required this.onTap,
    required this.backgroundImage,
  });

  final Function onTap;
  final String backgroundImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(), // Call the provided onTap function
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0), // Add border radius
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.cover, // Adjust as needed
            ),
          ),
        ],
      ),
    );
  }
}
