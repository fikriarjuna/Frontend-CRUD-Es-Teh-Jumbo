import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:tehjumbofirebase/Widget/Button.dart';
import 'package:tehjumbofirebase/shared/theme.dart';
import 'package:tehjumbofirebase/view/NotifPages/OrderSucces.dart';

enum PaymentMethod {
  cashOnDelivery,
  dana,
  ovo,
  goPay,
  // Tambahkan jenis pembayaran lainnya jika diperlukan
}

class PaymentPage extends StatefulWidget {
  final dynamic product;
  final int quantity;

  const PaymentPage({Key? key, required this.product, required this.quantity})
      : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentMethod? _selectedPaymentMethod = PaymentMethod.cashOnDelivery;
  User? user;
  Future<Map<String, dynamic>>? _futureAddress;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _futureAddress = _fetchAddress();
  }

  Future<Map<String, dynamic>> _fetchAddress() async {
    final url =
        Uri.parse('http://10.0.2.2:8000/api/address'); // Sesuaikan URL API
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);
      print('Response from API: $decodedResponse'); // Log response dari API
      return decodedResponse['data'][0]; // Ambil alamat pertama
    } else {
      throw Exception('Failed to load address');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Hitung total harga
    String cleanPrice =
        widget.product['price'].replaceAll(RegExp(r'[^0-9]'), '');
    int price = int.parse(cleanPrice);
    int tax = (price * 0.1).round(); // Hitung pajak 10%
    int totalItemPrice = price *
        widget.quantity; // Total harga untuk satu item dikalikan dengan jumlah
    int totalOrderPrice =
        totalItemPrice + tax; // Total harga keseluruhan dari pembelian

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: BackBtn(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Payment', style: titleStyle),
              Text('Pastikan sudah benar, lalu checkout!',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text('Item Ordered', style: menuStyle),
                  ),
                  SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(widget.product['name']),
                    subtitle: Text(widget.product['price']),
                    leading: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/empty_image.png',
                      image: widget.product['image_url'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/images/empty_image.png',
                            fit: BoxFit.cover);
                      },
                    ),
                    trailing: Text(
                      '${widget.quantity} Items',
                      style: textStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Detail Transaction', style: menuStyle),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.product['name']),
                      Text(
                        'Rp.$totalItemPrice',
                        style: txtBlack,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pajak 10%', style: textStyle),
                      Text('Rp.$tax', style: txtBlack),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Harga', style: textStyle),
                      Text(
                        'Rp.$totalOrderPrice',
                        style: txtBlack.copyWith(color: green),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Deliver To:', style: menuStyle),
                  SizedBox(height: 16),
                  FutureBuilder<Map<String, dynamic>>(
                    future: _futureAddress,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        var address = snapshot.data!;
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Nama', style: textStyle),
                                Text(user?.displayName ?? 'Nama tidak tersedia',
                                    style: txtBlack),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('No Telepon', style: textStyle),
                                Text(
                                    address['no_telepon'] ??
                                        'No Telepon tidak tersedia',
                                    style: txtBlack),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Alamat', style: textStyle),
                                Text(
                                    address['alamat'] ??
                                        'Alamat tidak tersedia',
                                    style: txtBlack),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Detail Lainnya', style: textStyle),
                                Text(
                                    address['detail_lain'] ??
                                        'Detail tidak tersedia',
                                    style: txtBlack),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return Text('No address data available');
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Text('Payment', style: menuStyle),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cash On Delivery (COD)', style: textStyle),
                      Radio(
                        activeColor: green,
                        value: PaymentMethod.cashOnDelivery,
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value as PaymentMethod?;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Dana', style: textStyle),
                      Radio(
                        activeColor: green,
                        value: PaymentMethod.dana,
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value as PaymentMethod?;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ovo', style: textStyle),
                      Radio(
                        activeColor: green,
                        value: PaymentMethod.ovo,
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value as PaymentMethod?;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('GoPay', style: textStyle),
                      Radio(
                        activeColor: green,
                        value: PaymentMethod.goPay,
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value as PaymentMethod?;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  CustomFillButton(
                    title: 'Checkout Now',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => OrderSucces()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
