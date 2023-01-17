import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:asmen/widget/alert.dart';
import '/main.dart';

import 'url.dart';

class AssetC extends GetxController {
  static AssetC get to => Get.find();
  DateTime dateNow = DateTime.now();
  var dateDetail;

  final formKey = GlobalKey<FormState>();
  final TextEditingController txtSearch = TextEditingController();
  final TextEditingController txtId = TextEditingController();
  final TextEditingController txtUName = TextEditingController();
  final TextEditingController txtAName = TextEditingController();
  final TextEditingController txtABrand = TextEditingController();
  final TextEditingController txtALocation = TextEditingController();
  final TextEditingController txtADate = TextEditingController();
  final TextEditingController txtAPeriod = TextEditingController();
  final TextEditingController txtAPrice = TextEditingController();
  final TextEditingController txtADetail1 = TextEditingController();
  final TextEditingController txtADetail2 = TextEditingController();
  final TextEditingController txtADetail3 = TextEditingController();
  final TextEditingController txtADetail4 = TextEditingController();
  final TextEditingController txtADetail5 = TextEditingController();

  final imgPicker = ImagePicker();
  File? frontImage;
  File? backImage;
  var assetFrontImage;
  var assetBackImage;
  var fImage;
  var bImage;

  List lAssetType = ['Tools', 'Office Equipment', 'Vehicle'];
  List lAsset = [];
  List lReminder = [];
  List lAssetExpires = [];
  List lT = [];
  List lE = [];
  List lV = [];
  List lRP = [];
  List lRE = [];
  List lRV = [];
  List dataAsset = [];
  List dtAsset = [];
  List dAsset = [];
  List lImage = [];
  String? selectedAsset;

  bool loading = false;

  resetData() {
    txtSearch.clear();
    txtId.clear();
    txtUName.clear();
    txtAName.clear();
    txtABrand.clear();
    txtALocation.clear();
    txtADate.clear();
    txtAPeriod.clear();
    txtAPrice.clear();
    txtADetail1.clear();
    txtADetail2.clear();
    txtADetail3.clear();
    txtADetail4.clear();
    txtADetail5.clear();
    selectedAsset = null;
    frontImage = null;
    backImage = null;
    lAsset.clear();
    lT.clear();
    lE.clear();
    lV.clear();
    lRP.clear();
    lRE.clear();
    lRV.clear();
    dataAsset.clear();
    dtAsset.clear();
    dAsset.clear();
    lImage.clear();
    lReminder.clear();
    lAssetExpires.clear();
    assetFrontImage = null;
    assetBackImage = null;
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  handleSearch(value) {
    dtAsset = dataAsset.where((x) => x['asset_name'].contains(value)).toList();
    txtSearch.text = '';

    update();
  }

  getStorage() async {
    lAsset = gs.read('asset');
    lAssetExpires = gs.read('asset_expires');
    lT = lAsset.where((x) => 'Tools' == (x['asset_type'])).toList();
    lE = lAsset.where((x) => 'Office Equipment' == (x['asset_type'])).toList();
    lV = lAsset.where((x) => 'Vehicle' == (x['asset_type'])).toList();
    await getListTools();
    await getListOfficeEquipment();
    await getListVehicle();

    lReminder = lRP + lRE + lRV;

    update();
  }

  createAssetID(assetID) {
    var id;
    if (assetID == 'Tools') {
      id = 'T';
    } else if (assetID == 'Office Equipment') {
      id = 'OF';
    } else if (assetID == 'Vehicle') {
      id = 'V';
    }

    return id;
  }

  selectType(value) {
    selectedAsset = value;
    if (selectedAsset == 'Tools') {
      txtAPeriod.text = '2';
    } else if (selectedAsset == 'Office Equipment') {
      txtAPeriod.text = '4';
    } else if (selectedAsset == 'Vehicle') {
      txtAPeriod.text = '5';
    }

    update();
  }

  selectDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: dateNow,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_pickedDate != null) {
      txtADate.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
    }
  }

  takePicture(image, type) async {
    Get.back();

    var imgCamera = await imgPicker.pickImage(
      imageQuality: 50,
      source: (type == 'c') ? ImageSource.camera : ImageSource.gallery,
    );
    if (imgCamera != null) {
      if (image == 'f') {
        frontImage = File(imgCamera.path);
        assetFrontImage = imgCamera.name;
        lImage.add(
          {
            'path': imgCamera.path,
            'image': assetFrontImage,
          },
        );
      } else {
        backImage = File(imgCamera.path);
        assetBackImage = imgCamera.name;
        lImage.add(
          {
            'path': imgCamera.path,
            'image': assetBackImage,
          },
        );
      }
    }

    update();
  }

  getListTools() {
    for (var i = 0; i < lT.length; i++) {
      var aa = DateTime.parse(lT[i]['asset_date']);
      var a = aa.toLocal();
      var date = DateFormat('yyyy-MM-dd').format(a);
      lT[i]['asset_date'] = date;

      if (aa.year + 2 == dateNow.year && aa.month == dateNow.month) {
        for (var j = 0; j < 8; j++) {
          if (a.day == dateNow.day + j) {
            lRP.add({
              "asset_id": lT[i]['asset_id'],
              "asset_type": lT[i]['asset_type'],
              "asset_pic": lT[i]['asset_pic'],
              "asset_name": lT[i]['asset_name'],
              "asset_brand": lT[i]['asset_brand'],
              "asset_location": lT[i]['asset_location'],
              "asset_date": lT[i]['asset_date'],
              "asset_period_day": a.day - dateNow.day,
              "asset_period": lT[i]['asset_period'],
              "asset_price": lT[i]['asset_price'],
              "asset_detail1": lT[i]['asset_detail1'],
              "asset_detail2": lT[i]['asset_detail2'],
              "asset_detail3": lT[i]['asset_detail3'],
              "asset_detail4": lT[i]['asset_detail4'],
              "asset_detail5": lT[i]['asset_detail5'],
              "asset_front_image": lT[i]['asset_front_image'],
              "asset_back_image": lT[i]['asset_back_image'],
            });
          }
        }
      }
    }
  }

  getListOfficeEquipment() {
    for (var i = 0; i < lE.length; i++) {
      var aa = DateTime.parse(lE[i]['asset_date']);
      var a = aa.toLocal();
      var date = DateFormat('yyyy-MM-dd').format(a);
      lE[i]['asset_date'] = date;

      if (aa.year + 4 == dateNow.year && aa.month == dateNow.month) {
        for (var j = 0; j < 8; j++) {
          if (a.day == dateNow.day + j) {
            lRE.add({
              "asset_id": lE[i]['asset_id'],
              "asset_type": lE[i]['asset_type'],
              "asset_pic": lE[i]['asset_pic'],
              "asset_name": lE[i]['asset_name'],
              "asset_brand": lE[i]['asset_brand'],
              "asset_location": lE[i]['asset_location'],
              "asset_date": lE[i]['asset_date'],
              "asset_period_day": a.day - dateNow.day,
              "asset_period": lE[i]['asset_period'],
              "asset_price": lE[i]['asset_price'],
              "asset_detail1": lE[i]['asset_detail1'],
              "asset_detail2": lE[i]['asset_detail2'],
              "asset_detail3": lE[i]['asset_detail3'],
              "asset_detail4": lE[i]['asset_detail4'],
              "asset_detail5": lE[i]['asset_detail5'],
              "asset_front_image": lE[i]['asset_front_image'],
              "asset_back_image": lE[i]['asset_back_image'],
            });
          }
        }
      }
    }
  }

  getListVehicle() {
    for (var i = 0; i < lV.length; i++) {
      var aa = DateTime.parse(lV[i]['asset_date']);
      var a = aa.toLocal();
      var date = DateFormat('yyyy-MM-dd').format(a);
      lV[i]['asset_date'] = date;

      if (aa.year + 5 == dateNow.year && aa.month == dateNow.month) {
        for (var j = 0; j < 8; j++) {
          if (a.day == dateNow.day + j) {
            lRV.add({
              "asset_id": lV[i]['asset_id'],
              "asset_type": lV[i]['asset_type'],
              "asset_pic": lV[i]['asset_pic'],
              "asset_name": lV[i]['asset_name'],
              "asset_brand": lV[i]['asset_brand'],
              "asset_location": lV[i]['asset_location'],
              "asset_date": lV[i]['asset_date'],
              "asset_period_day": a.day - dateNow.day,
              "asset_period": lV[i]['asset_period'],
              "asset_price": lV[i]['asset_price'],
              "asset_detail1": lV[i]['asset_detail1'],
              "asset_detail2": lV[i]['asset_detail2'],
              "asset_detail3": lV[i]['asset_detail3'],
              "asset_detail4": lV[i]['asset_detail4'],
              "asset_detail5": lV[i]['asset_detail5'],
              "asset_front_image": lV[i]['asset_front_image'],
              "asset_back_image": lV[i]['asset_back_image'],
            });
          }
        }
      }
    }
  }

  handleDetail(value) {
    dAsset = dtAsset.where((x) => value == (x['asset_id'])).toList();
  }

  saveTxt() {
    selectedAsset = dAsset[0]['asset_type'];
    txtUName.text = dAsset[0]['asset_pic'];
    txtAName.text = dAsset[0]['asset_name'];
    txtABrand.text = dAsset[0]['asset_brand'];
    txtALocation.text = dAsset[0]['asset_location'];
    txtADate.text = dAsset[0]['asset_date'];
    txtAPeriod.text = dAsset[0]['asset_period'];
    txtAPrice.text = dAsset[0]['asset_price'];
    txtADetail1.text = dAsset[0]['asset_detail1'];
    txtADetail2.text = dAsset[0]['asset_detail2'];
    txtADetail3.text = dAsset[0]['asset_detail3'];
    txtADetail4.text = dAsset[0]['asset_detail4'];
    txtADetail5.text = dAsset[0]['asset_detail5'];
    fImage = dAsset[0]['asset_front_image'];
    bImage = dAsset[0]['asset_back_image'];
  }

  setData(page) {
    if (page == 'Tools') {
      dataAsset = lT;
      dtAsset = dataAsset;
    } else if (page == 'Office Equipment') {
      dataAsset = lE;
      dtAsset = dataAsset;
    } else if (page == 'Vehicle') {
      dataAsset = lV;
      dtAsset = dataAsset;
    }
  }

  fetchAsset() async {
    try {
      var uri = Uri.parse(BaseURL.asset);
      var res = await http.get(uri, headers: header);
      var jsonD = jsonDecode(res.body);

      if (res.statusCode == 200) {
        await gs.write('asset', jsonD['data']);

        return jsonD;
      } else {
        Get.snackbar('Error', 'Error: ${jsonD['error']}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error: $e');
    }
  }

  fetchAssetExpires() async {
    try {
      var uri = Uri.parse(BaseURL.assetExpires);
      var res = await http.get(uri, headers: header);
      var jsonD = jsonDecode(res.body);

      if (res.statusCode == 200) {
        await gs.write('asset_expires', jsonD['data']);

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
      var uri = Uri.parse(BaseURL.asset);
      var res = await http.post(uri, body: {
        'asset_id': createAssetID(selectedAsset),
        'asset_type': selectedAsset,
        'asset_pic': txtUName.text,
        'asset_name': txtAName.text,
        'asset_brand': txtABrand.text,
        'asset_location': txtALocation.text,
        'asset_date': txtADate.text,
        'asset_period': txtAPeriod.text,
        'asset_price': txtAPrice.text,
        'asset_detail1': txtADetail1.text,
        'asset_detail2': txtADetail2.text,
        'asset_detail3': txtADetail3.text,
        'asset_detail4': txtADetail4.text,
        'asset_detail5': txtADetail5.text,
        'asset_front_image': assetFrontImage,
        'asset_back_image': assetBackImage,
        'type': 'add',
      });

      if (res.statusCode == 200) {
        Get.snackbar('Success', 'Aset berhasil ditambahkan');
      } else {
        Get.snackbar('Error', '${res.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error: $e');
    }
  }

  handleAddAssetExpires(asset) async {
    try {
      var uri = Uri.parse(BaseURL.assetExpires);
      var res = await http.post(uri, body: {
        "asset_expires_id": asset['asset_id'],
        "asset_type": asset['asset_type'],
        "asset_pic": asset['asset_pic'],
        "asset_name": asset['asset_name'],
        "asset_brand": asset['asset_brand'],
        "asset_location": asset['asset_location'],
        "asset_date": asset['asset_date'],
        "asset_period": asset['asset_period'],
        "asset_price": asset['asset_price'],
        "asset_detail1": asset['asset_detail1'],
        "asset_detail2": asset['asset_detail2'],
        "asset_detail3": asset['asset_detail3'],
        "asset_detail4": asset['asset_detail4'],
        "asset_detail5": asset['asset_detail5'],
        "asset_front_image": asset['asset_front_image'],
        "asset_back_image": asset['asset_back_image'],
      });

      if (res.statusCode == 200) {
      } else {
        print(res.body);
        Get.snackbar('Error', '${res.body}');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Error: $e');
    }
  }

  handleAddAssetID() async {
    try {
      DateTime date = DateTime.now();
      var uri = Uri.parse(BaseURL.assetID);
      await http.post(uri, body: {'date': date.toString()});
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Error: $e');
    }
  }

  handleDelete(asset, frontImage, backImage) async {
    try {
      var uri = Uri.parse(BaseURL.asset);
      var res = await http.post(uri, body: {
        'asset_id': asset,
        'asset_front_image': frontImage,
        'asset_back_image': backImage,
        'type': 'delete',
      });

      if (res.statusCode == 200) {
        Get.snackbar('Success', 'Aset berhasil dihapus');
      } else {
        Get.snackbar('Error', '${res.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error: $e');
    }
  }

  handleUpdate() async {
    try {
      var uri = Uri.parse(BaseURL.asset);
      var res = await http.post(uri, body: {
        'asset_id': dAsset[0]['asset_id'].toString(),
        'asset_type': selectedAsset,
        'asset_pic': txtUName.text,
        'asset_name': txtAName.text,
        'asset_brand': txtABrand.text,
        'asset_location': txtALocation.text,
        'asset_date': txtADate.text,
        'asset_period': txtAPeriod.text,
        'asset_price': txtAPrice.text,
        'asset_detail1': txtADetail1.text,
        'asset_detail2': txtADetail2.text,
        'asset_detail3': txtADetail3.text,
        'asset_detail4': txtADetail4.text,
        'asset_detail5': txtADetail5.text,
        'asset_front_image':
            (assetFrontImage != null) ? assetFrontImage : fImage,
        'asset_back_image': (assetBackImage != null) ? assetBackImage : bImage,
        'type': 'update',
      });

      if (res.statusCode == 200) {
        await handleUploadImage();
        await resetData();
        await fetchData();
        Get.snackbar('Success', 'Aset berhasil diupdate');
      } else {
        print(res.body);
        Get.snackbar('Error', '${res.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error: $e');
    }
  }

  uploadImage(path, image) async {
    try {
      var stream = new http.ByteStream(path.openRead());
      stream.cast();

      var length = await path.length();
      var uri = Uri.parse(BaseURL.image);
      var request = http.MultipartRequest('POST', uri);

      request.files.add(
        http.MultipartFile(
          'image',
          stream,
          length,
          filename: image,
        ),
      );

      request.send();
      resetData();
    } catch (e) {
      print(e);
    }
  }

  handleUploadImage() async {
    if (lImage.isNotEmpty) {
      for (var i = 0; i < lImage.length; i++) {
        File image = File(lImage[i]['path']);

        uploadImage(image, lImage[i]['image']);
      }
    }

    update();
  }

  fetchData() async {
    await fetchAsset();
    await fetchAssetExpires();
    await getStorage();
  }

  addAsset(context) async {
    if (formKey.currentState!.validate()) {
      if (frontImage != null && backImage != null) {
        loading = true;
        await handleAddAssetID();
        await handleAdd();
        await handleUploadImage();
        await resetData();
        await fetchData();
        loading = false;

        update();
        //Get.back();
        Navigator.pop(context);
      } else {
        Get.snackbar('Silahkan', 'Pilih Gambar');
      }
    }
  }

  updateAsset() async {
    await saveTxt();
    Get.toNamed('/form_asset');
  }

  deleteAsset(context, value, id, frontImage, backImage, page) {
    return myAlert(
      context,
      'Hapus Aset ?',
      onPressed: () async {
        loading = true;
        await handleAddAssetExpires(value);
        await handleDelete(id, frontImage, backImage);
        await resetData();
        await fetchData();

        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        loading = false;

        update();
      },
    );
  }

  deleteReminder(context, value) {
    return myAlert(
      context,
      'Hapus Aset ?',
      onPressed: () async {
        await handleAddAssetExpires(value);
        await handleDelete(
          value['asset_id'],
          value['asset_front_image'],
          value['asset_back_image'],
        );
        await resetData();
        await fetchData();
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }
}
