import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tehjumbofirebase/Widget/Button.dart';
import 'package:tehjumbofirebase/shared/theme.dart';
import 'package:tehjumbofirebase/view/EditAddress.dart';

class MyAddressPage extends StatefulWidget {
  const MyAddressPage({Key? key}) : super(key: key);

  @override
  _MyAddressPageState createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {
  late Future<List<dynamic>> _futureAddresses;

  @override
  void initState() {
    super.initState();
    _futureAddresses = _fetchAddresses();
  }

  Future<List<dynamic>> _fetchAddresses() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/address');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Jika request berhasil, parse response.body ke dalam bentuk List<dynamic>
      return json.decode(response.body)['data'];
    } else {
      // Jika request gagal, lempar sebuah exception
      throw Exception('Failed to load addresses');
    }
  }

  Future<void> _deleteAddress(String id) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/address/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      // Jika delete berhasil, refresh data alamat
      setState(() {
        _futureAddresses = _fetchAddresses();
      });
    } else {
      // Jika delete gagal, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete address'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: BackBtn(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'My Addresses',
          style: titleStyle,
        ),
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: _futureAddresses,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var address = snapshot.data![index];
                  return ListTile(
                    title: Text(
                      address['alamat'],
                      style: txtBlack,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'No Telepon: ${address['no_telepon'] ?? 'No Telepon tidak tersedia'}',
                            style: textStyle),
                        Text('Detail Lain: ${address['detail_lain'] ?? ''}',
                            style: textStyle),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditAddress(
                                  address: address,
                                ),
                              ),
                            ).then((editedAddress) {
                              if (editedAddress != null) {
                                // Handle jika ada perubahan dari EditAddress
                                // Misalnya, implementasi update ke server atau refresh data
                                print('Address updated: $editedAddress');
                                setState(() {
                                  // Implementasi refresh data atau sesuaikan kebutuhan
                                  _futureAddresses = _fetchAddresses();
                                });
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete Address'),
                                  content: Text(
                                      'Are you sure you want to delete this address?'),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Delete'),
                                      onPressed: () {
                                        _deleteAddress(
                                            address['id'].toString());
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Text('No data available');
            }
          },
        ),
      ),
    );
  }
}
