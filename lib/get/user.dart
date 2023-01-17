import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:asmen/validation.dart';
import '/main.dart';

import 'url.dart';

class UserC extends GetxController {
  static UserC get to => Get.find();

  final GlobalKey<FormState> keyUser = GlobalKey<FormState>();
  final TextEditingController txtUsername = TextEditingController();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPass = TextEditingController();
  final TextEditingController txtPhone = TextEditingController();
  final TextEditingController txtPosition = TextEditingController();
  final TextEditingController txtTypeUser = TextEditingController();

  bool secureText = true;

  List typeUser = ['Admin', 'Manager'];

  List lUser = [];
  List dataUser = [];
  List detailUser = [];
  String type = 'add';
  String? selectedType;
  String? user;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  showHide() {
    secureText = !secureText;
    update();
  }

  resetData() {
    lUser.clear();
    txtUsername.text = '';
    txtName.text = '';
    txtEmail.text = '';
    txtPass.text = '';
    txtPhone.text = '';
    txtPosition.text = '';
    txtTypeUser.text = '';
    selectedType = null;
    user = null;

    update();
  }

  //handleSearch() {}

  saveTxt() {
    txtUsername.text = dataUser[0]['username'];
    txtName.text = dataUser[0]['name_user'];
    txtEmail.text = dataUser[0]['email_user'];
    txtPass.text = dataUser[0]['password_user'];
    txtPhone.text = dataUser[0]['phone_number_user'];
    txtPosition.text = dataUser[0]['jabatan_user'];
    txtTypeUser.text = dataUser[0]['type_user'];
    selectedType = dataUser[0]['type_user'];
  }

  getStorage() async {
    lUser = await gs.read('user');
    user = (user != null) ? user : gs.read('dataUser')['username'];
    dataUser = lUser.where((x) => user == (x['username'])).toList();

    await saveTxt();

    update();
  }

  selectType(value) {
    selectedType = value;
    update();
  }

  fetchData() async {
    try {
      var uri = Uri.parse(BaseURL.user);
      var res = await http.get(uri, headers: header);

      var jsonD = jsonDecode(res.body);

      if (res.statusCode == 200) {
        await gs.write('user', jsonD['data']);
        getStorage();

        return jsonD;
      } else {
        Get.snackbar('Error', 'Error: ${jsonD['error']}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error: $e');
    }
  }

  handleAdd() async {
    if (keyUser.currentState!.validate()) {
      try {
        var uri = Uri.parse(BaseURL.user);
        var res = await http.post(uri, body: {
          'username': txtUsername.text,
          'name_user': txtName.text,
          'email_user': txtEmail.text,
          'password_user': generateMd5(txtPass.text),
          'phone_number_user': txtPhone.text,
          'jabatan_user': txtPosition.text,
          'type_user': selectedType,
          'type': 'add',
        });
        if (res.statusCode == 200) {
          Get.snackbar('Success', 'User berhasil didaftarkan');

          Get.offNamed('/menu');
          Get.toNamed('/setting');
          resetData();
          fetchData();
        } else {
          print(res.body);
          Get.offNamed('/menu');
          Get.toNamed('/setting');
          Get.snackbar('Error', '${res.body}');
        }
      } catch (e) {
        Get.snackbar('Error', 'Error: $e');
      }
    }
  }

  handleUpdate() async {
    if (keyUser.currentState!.validate()) {
      try {
        var uri = Uri.parse(BaseURL.user);
        var res = await http.post(uri, body: {
          'username': txtUsername.text,
          'name_user': txtName.text,
          'email_user': txtEmail.text,
          'password_user': (txtPass.text == dataUser[0]['password_user'])
              ? txtPass.text
              : generateMd5(txtPass.text),
          'phone_number_user': txtPhone.text,
          'jabatan_user': txtPosition.text,
          'type_user': selectedType,
          'type': 'update',
        });

        if (res.statusCode == 200) {
          Get.snackbar('Success', 'User berhasil diupdate');

          if (gs.read('dataUser')['username'] == txtUsername.text) {
            gs.read('dataUser')['name_user'] = txtName.text;
            gs.read('dataUser')['email_user'] = txtEmail.text;
          }

          Get.offNamed('/menu');
          if (gs.read('dataUser')['type_user'] == 'Super Admin') {
            Get.toNamed('/setting');
          }
          resetData();
          fetchData();
        }
      } catch (e) {
        Get.snackbar('Error', 'Error: $e');
      }
    }
  }

  handleDelete() async {
    try {
      var uri = Uri.parse(BaseURL.user);
      var res = await http.post(uri, body: {
        'username': txtUsername.text,
        'type': 'delete',
      });

      if (res.statusCode == 200) {
        Get.snackbar('Success', 'User berhasil dihapus');

        Get.offNamed('/menu');
        Get.toNamed('/setting');
        resetData();
        fetchData();
      } else {
        Get.snackbar('Error', '${res.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error: $e');
    }
  }

  goDetail(value) async {
    user = await value;
    await getStorage();
    Get.toNamed('/profile');
  }

  addUser() async {
    Get.toNamed('/profile', arguments: 'add');
    txtUsername.text = '';
    txtName.text = '';
    txtEmail.text = '';
    txtPass.text = '';
    txtPhone.text = '';
    txtPosition.text = '';
    txtTypeUser.text = '';
    selectedType = null;
    user = null;
  }
}
