
import 'package:flutter/material.dart';

import 'package:tehjumbofirebase/Widget/Button.dart';
import 'package:tehjumbofirebase/shared/theme.dart';
import 'package:tehjumbofirebase/view/Homepage.dart';

class SignUpSucces extends StatelessWidget {
  const SignUpSucces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset('assets/logo/left_flowers_logo.png')),
                Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/logo/flowers_logo.png')),
                Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset('assets/logo/right_flowers_logo.png'))
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                top: 450,
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'Yeay! Berhasil',
                    style: titleStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Sekarang anda dapat memesan',
                    style: subtitleStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(' es teh pilihan anda!'),
                  SizedBox(
                    height: 30,
                  ),
                  CustomFillButton(
                    title: 'Find Your Iced Tea',
                    width: 200,
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Homepage()));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
