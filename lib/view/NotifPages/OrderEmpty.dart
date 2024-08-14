
import 'package:flutter/material.dart';
import 'package:tehjumbofirebase/Widget/Button.dart';
import 'package:tehjumbofirebase/shared/theme.dart';
import 'package:tehjumbofirebase/view/Homepage.dart';


class OrderEmpty extends StatelessWidget {
  const OrderEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset('assets/images/empty_image.png'),
            ),
            Text(
              'Huhh! Hauss',
              style: titleStyle.copyWith(fontSize: 20),
            ),
            Text(
              'Sepertinya anda belum memesan',
              style: subtitleStyle,
            ),
            Text(
              'minuman apapun!',
              style: subtitleStyle,
            ),
            SizedBox(
              height: 12,
            ),
            CustomFillButton(
              title: 'Find Iced Tea',
              width: 300,
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Homepage()));
              },
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
