import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tehjumbofirebase/shared/theme.dart';
import 'package:tehjumbofirebase/view/AddProduct.dart';
import 'package:tehjumbofirebase/view/EditProduct.dart';
import 'package:tehjumbofirebase/view/auth/Sign-in.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final String url = 'http://10.0.2.2:8000/api/products';

  Future getProduct() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future deleteProduct(String productId) async {
    final String url = 'http://10.0.2.2:8000/api/products/' + productId;

    var response = await http.delete(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Addproduct()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          'Admin Page',
          style: titleStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
            );
          },
          icon: Icon(Icons.logout),
          color: red,
        ),
      ),
      body: FutureBuilder(
          future: getProduct(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Card(
                        color: bgColor,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  height: 150,
                                  width: 150,
                                  child: Image.network(snapshot.data['data']
                                      [index]['image_url'])),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data['data'][index]['name'],
                                    style: menuStyle,
                                  ),
                                  Text(
                                    snapshot.data['data'][index]['price'],
                                    style: textStyle,
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Editproduct(
                                                        product: snapshot
                                                                .data['data']
                                                            [index],
                                                      )));
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          deleteProduct(snapshot.data['data']
                                                      [index]['id']
                                                  .toString())
                                              .then((value) => {
                                                    setState(() {}),
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                'Produk berhasil di hapus')))
                                                  });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Text('data erorr');
            }
          }),
    );
  }
}
