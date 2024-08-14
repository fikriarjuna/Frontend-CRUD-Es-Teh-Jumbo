
import 'package:flutter/material.dart';
import 'package:tehjumbofirebase/Widget/BottomNavBar.dart';
import 'package:tehjumbofirebase/Widget/Button.dart';
import 'package:tehjumbofirebase/shared/theme.dart';
import 'package:tehjumbofirebase/view/Homepage.dart';
import 'package:tehjumbofirebase/view/Profile.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    super.key,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int _currentIndex = 1;
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Order', style: titleStyle),
              Text('Tunggu pesanan anda dengan tenang  :)',
                  style: subtitleStyle),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: CustomTextButton(
                          title: 'In Progres',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          showUnderline: false,
                          onPressed: () {
                            setState(() {
                              _selectedPageIndex = 0;
                            });
                          },
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: CustomTextButton(
                          title: 'Past Order',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          showUnderline: false,
                          onPressed: () {
                            setState(() {
                              _selectedPageIndex = 1;
                            });
                          },
                        )),
                  ],
                ),
                // SizedBox(
                //   height: 18,
                // ),
                IndexedStack(
                  index: _selectedPageIndex,
                  children: [
                    Container(
                      child: Text('Orderan Masih Eror'),
                    ),
                    Container(
                      child: Text('Kode Belum Sempurna'),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      )),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              // Navigasi ke halaman Home
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
              );
              break;
            case 1:
              //
              break;
            case 2:
              // Navigasi ke halaman Profile
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
