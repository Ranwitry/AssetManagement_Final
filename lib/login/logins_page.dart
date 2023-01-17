import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asmen/get/login.dart';
import 'package:asmen/validation.dart';
import 'package:asmen/widget/common.dart';

class PageLogin extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return GetBuilder<LoginC>(
      init: LoginC(),
      builder: (data) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: data.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _image(c),
                  _title(),
                  _email(),
                  _pass(),
                  _button(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _text(text) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 20),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  _image(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Image.asset(
        "images/lampion.png",
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width,
        //fit: BoxFit.fitWidth
      ),
    );
  }

  _title() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 40),
      child: Text(
        "Masuk",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xffA1616A),
          fontSize: 55,
        ),
      ),
    );
  }

  _email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _text('Username'),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
          child: MyTextFormField(
            controller: LoginC.to.txtUser,
            validator: (value) => emptyValue(value),
            hintText: 'Masukan Username',
          ),
        ),
      ],
    );
  }

  _pass() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _text('Password'),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
          child: MyTextFormField(
            controller: LoginC.to.txtPass,
            obscureText: LoginC.to.secureText,
            maxLines: 1,
            validator: (value) => valueMustBe6(value),
            hintText: 'Masukan Kata Sandi',
            suffixIcon: IconButton(
              onPressed: () => LoginC.to.showHide(),
              icon: Icon(
                LoginC.to.secureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _button() {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 30, right: 20, bottom: 10),
      child: LoginC.to.loading
          ? MyTextButton(
              text: 'Masuk',
              onPressed: () => LoginC.to.handleLogin(),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
