import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tehjumbofirebase/Widget/Button.dart';
import 'package:tehjumbofirebase/Widget/CustomFormField.dart';
import 'package:tehjumbofirebase/shared/theme.dart';
import 'package:tehjumbofirebase/view/AdminPage.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({super.key});

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _namaController = TextEditingController();
  TextEditingController _hargaController = TextEditingController();
  TextEditingController _imageController = TextEditingController();

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Data tidak boleh kosong';
    }
    return null;
  }

  Future saveProduct() async {
    final response =
        await http.post(Uri.parse('http://10.0.2.2:8000/api/products'), body: {
      "name": _namaController.text,
      "price": _hargaController.text,
      "image_url": _imageController.text,
    });
    return json.decode(response.body);
  }

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
              Text('Add Product', style: titleStyle),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 25, right: 25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomFormField(
                  controller: _namaController,
                  title: 'Nama Produk',
                  labelText: 'Masukan Nama Produk',
                  validator: _validateNotEmpty,
                ),
                SizedBox(height: 18),
                CustomFormField(
                  controller: _hargaController,
                  title: 'Harga',
                  labelText: 'Masukan Harga',
                  validator: _validateNotEmpty,
                ),
                SizedBox(height: 18),
                CustomFormField(
                  controller: _imageController,
                  title: 'Image Url',
                  labelText: 'Masukan Image Url',
                  validator: _validateNotEmpty,
                ),
                SizedBox(height: 18),
                CustomFillButton(
                  title: 'Tambah',
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      saveProduct().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminPage()));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Produk berhasil di tambah')));
                      });
                    } else {
                      // Ada input yang tidak valid
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
