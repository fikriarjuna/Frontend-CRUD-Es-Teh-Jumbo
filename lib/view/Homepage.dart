import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tehjumbofirebase/Widget/BottomNavBar.dart';
import 'package:tehjumbofirebase/Widget/Card.dart';
import 'package:tehjumbofirebase/shared/theme.dart';
import 'package:tehjumbofirebase/view/Detail.dart';
import 'package:tehjumbofirebase/view/NotifPages/OrderEmpty.dart';
import 'package:tehjumbofirebase/view/Order.dart';
import 'package:tehjumbofirebase/view/Profile.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Homepage> {
  int _currentIndex = 0;
  bool isOrderEmpty = true;

  final String url = 'http://10.0.2.2:8000/api/products';

  Future<List<dynamic>> getProduct() async {
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bgColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ice Tea Market', style: titleStyle),
            Text('Haus? Es teh jumbo solusinya', style: subtitleStyle),
          ],
        ),
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  child: Image.asset('assets/images/profile_image.png')),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            var products = snapshot.data as List<dynamic>;
            return ListView(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 50),
                  child: Row(
                    children: products.map((product) {
                      return CustomCard(
                        title: product['name'],
                        price: product['price'],
                        img: product['image_url'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailPage(product: product),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: products.map((product) {
                    return CustCard(
                      title: product['name'],
                      price: product['price'],
                      img: product['image_url'],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(product: product),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            );
          } else {
            return Center(child: Text('Data error'));
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              // Navigasi ke halaman Home (tidak perlu navigasi karena sudah berada di halaman Home)
              break;
            case 1:
              // Navigasi ke halaman order
              if (isOrderEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderEmpty()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderPage()),
                );
              }
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
