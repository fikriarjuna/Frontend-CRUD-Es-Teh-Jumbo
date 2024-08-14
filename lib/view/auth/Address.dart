import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tehjumbofirebase/Widget/Button.dart';
import 'package:tehjumbofirebase/Widget/CustomFormField.dart';
import 'package:tehjumbofirebase/shared/theme.dart';
import 'package:tehjumbofirebase/view/NotifPages/SignUpSucces.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _noHpController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _detailController = TextEditingController();

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Data tidak boleh kosong';
    }
    return null;
  }

  Future saveAddress() async {
    final response =
        await http.post(Uri.parse('http://10.0.2.2:8000/api/address'), body: {
      "no_telpon": _noHpController.text,
      "alamat": _alamatController.text,
      "detail_lain": _detailController.text,
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
              Text('Address', style: titleStyle),
              Text('Pastikan alamat anda benar!', style: subtitleStyle),
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
                  controller: _noHpController,
                  title: 'No Handphone',
                  labelText: 'Masukan No Handphone Anda',
                  validator: _validateNotEmpty,
                ),
                SizedBox(height: 18),
                CustomFormField(
                  controller: _alamatController,
                  title: 'Alamat',
                  labelText: 'Masukan alamat anda',
                  validator: _validateNotEmpty,
                ),
                SizedBox(height: 18),
                CustomFormField(
                  controller: _detailController,
                  title: 'Detail Lain',
                  labelText: 'Masukan detail lainnya',
                ),
                SizedBox(height: 18),
                CustomFillButton(
                  title: 'Sign Up Now',
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      saveAddress().then((value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpSucces(),
                          ),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Gagal menambahkan alamat: $error'),
                          ),
                        );
                      });
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
