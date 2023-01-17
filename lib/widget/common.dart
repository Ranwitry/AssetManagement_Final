import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asmen/menu/drawerbar.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    this.controller,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.labelText,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines,
    this.outline = 5,
  });

  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? hintText;
  final String? labelText;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final double outline;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,
      readOnly: readOnly,
      keyboardType: keyboardType,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.only(left: 10),
        fillColor: Color(0xffF6F9FE),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: TextStyle(fontSize: 14.0),
    );
  }
}

class MyTextButton extends StatelessWidget {
  const MyTextButton({this.onPressed, required this.text});

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Color(0xffDF9A9A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    this.text,
    this.backButton = false,
    this.body,
    this.drawer = false,
  });

  final String? text;
  final Widget? body;
  final bool backButton;
  final bool drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text!, style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xffA1616A),
        leading: (backButton == true)
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back(),
              )
            : Text(''),
      ),
      body: body,
      drawer: (drawer == true) ? DrawerBar() : Text(''),
    );
  }
}
