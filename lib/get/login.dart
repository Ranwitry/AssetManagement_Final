import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:asmen/get/url.dart';
import 'package:asmen/validation.dart';
import '/main.dart';

class LoginC extends GetxController {
  static LoginC get to => Get.find(); // fungsi manggil ke semua folder

  final formKey = GlobalKey<FormState>();
  final txtUser = TextEditingController();
  final txtPass = TextEditingController();

  bool secureText = true;
  bool loading = true;

  showHide() {
    secureText = !secureText;
    update();
  }

  showLoading() {
    loading = !loading;
    update();
  }

  handleLogin() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      try {
        var uri = Uri.parse(BaseURL.login);
        var res = await http.post(uri, body: {
          'username': txtUser.text,
          'password': generateMd5(txtPass.text),
        });

        if (res.statusCode == 200) {
          var data = jsonDecode(res.body);
          if (data['data'].length != 0) {
            await gs.write('login', true);
            await gs.write('dataUser', data['data']);
            await gs.write('token', data['token']);

            Get.snackbar('Success', 'Login Berhasil');
            Get.offAllNamed('/greetings');

            showLoading();
          } else {
            gs.write('login', false);
            Get.snackbar('Error', 'Username/Password Salah');

            showLoading();
          }
        } else {
          print(res.body);
          gs.write('login', false);
          Get.snackbar('Error', 'Username/Password Salah');

          showLoading();
        }
      } catch (e) {
        print(e);
        showLoading();
        Get.snackbar('Error', 'Username/Password Salah');
      }
    }
  }
}
