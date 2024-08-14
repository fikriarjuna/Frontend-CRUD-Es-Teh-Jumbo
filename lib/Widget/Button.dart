import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tehjumbofirebase/shared/theme.dart';

class CustomFillButton extends StatelessWidget {
  const CustomFillButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.height = 50,
    this.onPressed,
    this.backgroundColor = const Color.fromRGBO(0, 228, 23, 1),
    this.borderColor = Colors.transparent,
    this.textStyle,
  });

  final String title;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: borderColor),
          ),
        ),
        child: Text(title, style: textStyle ?? btntext),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.title,
    // this.width = double.infinity,
    // this.height = 24,
    this.fontSize = 12,
    this.onPressed,
    this.showUnderline = true,
    this.color = const Color.fromRGBO(0, 228, 23, 1) ,
    this.fontWeight = FontWeight.normal,
  });

  final String title;
  final Color color;
  // final double width;
  // final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback? onPressed;
  final bool showUnderline;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: width,
      // height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Text(title,
            style: GoogleFonts.poppins(
                color: color,
                fontSize: fontSize,
                fontWeight: fontWeight,
                decoration: showUnderline
                    ? TextDecoration.underline
                    : TextDecoration.none,
                decorationColor: color)),
      ),
    );
  }
}

class CustomIconBtn extends StatelessWidget {
  const CustomIconBtn({
    super.key,
    required this.img,
    required this.title,
    required this.width,
    this.onPressed,
  });

  final String img;
  final String title;
  final double width;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          color: shadeGreen, borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Image.asset(img),
          SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: GoogleFonts.poppins(color: grey, fontSize: 12),
          )
        ],
      ),
    );
  }
}

class BackBtn extends StatelessWidget {
  const BackBtn({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: green,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8)),
          child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        onPressed: onPressed);
  }
}

class incrementBtn extends StatelessWidget {
  const incrementBtn({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border.all(style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon),
      ),
    );
  }
}
