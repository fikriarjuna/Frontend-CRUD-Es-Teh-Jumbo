
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tehjumbofirebase/Widget/Button.dart';
import 'package:tehjumbofirebase/shared/theme.dart';
import 'package:tehjumbofirebase/view/Homepage.dart';
import 'package:tehjumbofirebase/view/Order.dart';

class OrderSucces extends StatelessWidget {
  const OrderSucces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset('assets/images/succes_image.png'),
            ),
            Text(
              'Pesanan Berhasil',
              style: titleStyle.copyWith(fontSize: 20),
            ),
            Text(
              'Anda hanya perlu menunggu dirumah,',
              style: subtitleStyle,
            ),
            Text(
              'kami akan segera membuat dan mengirim',
              style: subtitleStyle,
            ),
            Text(
              'pesanan anda!',
              style: subtitleStyle,
            ),
            SizedBox(
              height: 12,
            ),
            CustomFillButton(
              title: 'Find Your Iced Tea',
              width: 300,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Homepage()));
              },
            ),
            SizedBox(
              height: 12,
            ),
            CustomFillButton(
              title: 'View My Order',
              textStyle: txtgreen,
              width: 300,
              backgroundColor: Colors.transparent,
              borderColor: green,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
