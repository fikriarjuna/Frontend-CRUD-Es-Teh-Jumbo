import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tehjumbofirebase/Widget/Button.dart';
import 'package:tehjumbofirebase/Widget/CustomFormField.dart';
import 'package:tehjumbofirebase/shared/theme.dart';

class EditAddress extends StatefulWidget {
  final Map<String, dynamic> address;

  const EditAddress({Key? key, required this.address}) : super(key: key);

  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _noHpController;
  late TextEditingController _alamatController;
  late TextEditingController _detailController;

  @override
  void initState() {
    super.initState();
    _noHpController =
        TextEditingController(text: widget.address['no_telpon'].toString());
    _alamatController =
        TextEditingController(text: widget.address['alamat'].toString());
    _detailController =
        TextEditingController(text: widget.address['detail_lain'].toString());
  }

  @override
  void dispose() {
    _noHpController.dispose();
    _alamatController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Data tidak boleh kosong';
    }
    return null;
  }

  Future<Map<String, dynamic>> editAddress() async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:8000/api/address/' +
          widget.address['id'].toString()),
      body: {
        "no_telpon": _noHpController.text,
        "alamat": _alamatController.text,
        "detail_lain": _detailController.text,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update address');
    }
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
              Text('Edit Address', style: titleStyle),
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
                  title: 'Simpan',
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      editAddress().then((value) {
                        Navigator.pop(context, {
                          'no_telpon': _noHpController.text,
                          'alamat': _alamatController.text,
                          'detail_lain': _detailController.text,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Alamat berhasil diubah')),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Gagal menyimpan perubahan: $error'),
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
