import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '/main.dart';

import 'url.dart';

class CategoryC extends GetxController {
  static CategoryC get to => Get.find();

  final TextEditingController txtId = TextEditingController();

  List lCategory= [];
  String type = 'add';

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  resetData() {
    txtId.text = '';
    lCategory.clear();
  }

  handleSearch() {}

  getStorage() async {
    lCategory = gs.read('category');

    update();
  }

  fetchData() async {
    try {
      var uri = Uri.parse(BaseURL.asset);
      var res = await http.get(uri);
      var jsonD = jsonDecode(res.body);

      if (res.statusCode == 200) {
        await gs.write('category', jsonD['data']);
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
    try {
      var uri = Uri.parse(BaseURL.category);
      var res = await http.post(uri, body: {
        'category_id': txtId.text,
        'asset_type': 'asset_type',
        'period': 'period',
        'type': 'add',
      });
      if (res.statusCode == 200) {
        Get.snackbar('Success', 'Success Add Data');

        resetData();
        fetchData();
      } else {
        Get.snackbar('Error', '${res.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error: $e');
    }
  }

  handleDelete() async {
    try {
      var uri = Uri.parse(BaseURL.category);
      var res = await http.post(uri, body: {
        'category_id': txtId.text,
        'type': 'delete',
      });

      if (res.statusCode == 200) {
        Get.snackbar('Success', 'Success Delete Data');

        resetData();
        fetchData();
      } else {
        Get.snackbar('Error', '${res.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error: $e');
    }
  }

  handleUpdate() async {
        try {
      var uri = Uri.parse(BaseURL.category);
      var res = await http.post(uri, body: lCategory[0]);

      if (res.statusCode == 200) {
        Get.snackbar('Success', 'Success Update Data');

        resetData();
        fetchData();
      }
    } catch (e) {
      Get.snackbar('Error', 'Error: $e');
    }
  }
}
