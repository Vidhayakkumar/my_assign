import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldForm extends StatelessWidget {
  final TextEditingController controller ;
  final String hintText;
  final String? Function(String?)? validator;
  TextFieldForm({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hint: Text(hintText),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r)
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r)
        ),
      ),
    );
  }
}
