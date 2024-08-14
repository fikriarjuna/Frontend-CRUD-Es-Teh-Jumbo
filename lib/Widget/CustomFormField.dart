import 'package:flutter/material.dart';
import 'package:tehjumbofirebase/shared/theme.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.title,
    required this.labelText,
    this.obscureText = false,
    this.controller,
    this.isShowTitle = true,
    this.onTap,
    this.readOnly = false,
    this.inputType = TextInputType.name,
    this.validator,
  });

  final String title;
  final String labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final bool isShowTitle;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextInputType inputType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowTitle) Text(title, style: menuStyle),
        if (isShowTitle)
          const SizedBox(
            height: 12,
          ),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          keyboardType: inputType,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            label: Text(labelText),
            hintText: !isShowTitle ? title : null,
            fillColor: bgColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: grey),
            ),
            contentPadding: const EdgeInsets.all(18),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
