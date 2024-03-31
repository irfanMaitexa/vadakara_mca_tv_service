import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? errorText;
  final TextInputType? input;
  final Widget ? suffixIcon;
  final bool ? obscureText;
  final Color ? borderColor;
  String? Function(String?)? validator;
  final bool ? isEnabled;
  final int ? maxline;
  final int ? minLine;

   CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.input,
    this.errorText,
    this.suffixIcon,
    this.obscureText,
    this.borderColor,
    this.validator,
    this.maxline,
    this.minLine,
    this.isEnabled
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide:  BorderSide(
        color: borderColor?? Colors.white,
      ),
    );
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: input,
      enabled: isEnabled,
      maxLines: maxline??1,
      minLines: minLine,
      obscureText: obscureText??false,
      decoration: InputDecoration(

          hintText: hintText,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          border: outlineInputBorder,
          errorText: errorText,
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.w400),


          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: Colors.red))),
    );
  }
}
