import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintext;
  final TextEditingController? controller;
  final bool isObscureText;
  final bool readonly;
  final VoidCallback? onTap;
  const CustomField(
      {super.key,
      required this.hintext,
      required this.controller,
      this.isObscureText = false,
      this.readonly = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readonly,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintext,
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "$hintext is missing!";
        }
        return null;
      },
      obscureText: isObscureText,
    );
  }
}
