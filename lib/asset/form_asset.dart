import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:asmen/get/asset.dart';
import 'package:asmen/widget/alert.dart';
import 'package:asmen/widget/dropdown.dart';

class FormAsset extends StatefulWidget {
  @override
  State<FormAsset> createState() => _FormAssetState();
}

class _FormAssetState extends State<FormAsset> {
  var type = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Aset"),
        backgroundColor: Color(0xffA1616A),
      ),
      body: _body(context),
    );
  }

  _body(context) {
    return SingleChildScrollView(
      child: GetBuilder<AssetC>(
        init: AssetC(),
        builder: (c) {
          return Form(
            key: c.formKey,
            child: Column(
              children: [
                _form('Jenis Aset', _dropdown(c)),
                _form('User PIC', _textField('User PIC', c.txtUName)),
                _form('Nama Barang', _textField('Nama Aset', c.txtAName)),
                _form('Merk', _textField('Merk Aset', c.txtABrand)),
                _form('Lokasi', _textField('Lokasi Aset', c.txtALocation)),
                _form(
                  'Tanggal Terima',
                  _textField(
                    'Tanggal Terima',
                    c.txtADate,
                    r: true,
                    icon: IconButton(
                      icon: Icon(Icons.date_range, size: 30),
                      onPressed: () => c.selectDate(context),
                    ),
                  ),
                ),
                _form(
                  'Masa Aset',
                  _textField('Masa Aset', c.txtAPeriod, r: true),
                ),
                _form(
                  'Harga Perolehan',
                  _textField(
                    'Harga Beli',
                    c.txtAPrice,
                    k: TextInputType.number,
                    i: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ),
                ),
                if (c.selectedAsset != null) _assetDetail1(c),
                if (c.selectedAsset != null) _assetDetail2(c),
                if (c.selectedAsset != null) _assetDetail3(c),
                if (c.selectedAsset != null) _assetDetail4(c),
                if (c.selectedAsset != null) _assetDetail5(c),
                _formImage(c),
                (c.loading == false)
                    ? _button(
                        textButton: AssetC.to.dAsset.isEmpty
                            ? 'Tambah Aset'
                            : 'Edit Aset',
                        onPressed: () async {
                          if (AssetC.to.dAsset.isEmpty) {
                            await AssetC.to.addAsset(context);
                            //Navigator.pop(context);
                          } else if (AssetC.to.dAsset.isNotEmpty) {
                            await AssetC.to.handleUpdate();
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            
                          }
                        },
                      )
                    : Center(child: CircularProgressIndicator())
              ],
            ),
          );
        },
      ),
    );
  }

  _form(text, widget) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(text)),
          Expanded(flex: 2, child: widget),
        ],
      ),
    );
  }

  _formImage(c) {
    return (type == 'add')
        ? Column(
            children: [
              _form(
                'Gambar Depan',
                _myImage(
                  c.frontImage,
                  onTap: () => myDoubleAlert(
                    context,
                    'Ambil Foto',
                    'Buka Camera',
                    'Buka Galery',
                    onPressed1: () => c.takePicture('f', 'c'),
                    onPressed2: () => c.takePicture('f', 'g'),
                  ),
                ),
              ),
              _form(
                'Gambar Belakang',
                _myImage(
                  c.backImage,
                  onTap: () => myDoubleAlert(
                    context,
                    'Ambil Foto',
                    'Buka Camera',
                    'Buka Galery',
                    onPressed1: () => c.takePicture('b', 'c'),
                    onPressed2: () => c.takePicture('b', 'g'),
                  ),
                ),
              ),
            ],
          )
        : _button(
            textButton: 'Edit Image',
            onPressed: () {
              setState(() {
                type = 'add';
              });
            },
          );
  }

  _assetDetail1(c) {
    var text;
    (c.selectedAsset != null)
        ? (c.selectedAsset == 'Office Equipment')
            ? text = 'Serial Number'
            : (c.selectedAsset == 'Vehicle')
                ? text = 'Tahun Produksi'
                : text = ''
        : text = '';

    return Column(
      children: [
        if (c.selectedAsset != 'Tools')
          _form(text, _textField(text, c.txtADetail1))
      ],
    );
  }

  _assetDetail2(c) {
    var text;
    (c.selectedAsset != null)
        ? (c.selectedAsset == 'Office Equipment')
            ? text = 'Tipe Processor'
            : (c.selectedAsset == 'Vehicle')
                ? text = 'Plat Nomor'
                : text = ''
        : text = '';

    return Column(
      children: [
        if (c.selectedAsset != 'Tools')
          _form(text, _textField(text, c.txtADetail2))
      ],
    );
  }

  _assetDetail3(c) {
    var text;
    (c.selectedAsset != null)
        ? (c.selectedAsset == 'Office Equipment')
            ? text = 'RAM'
            : (c.selectedAsset == 'Vehicle')
                ? text = 'Tipe Mesin'
                : text = ''
        : text = '';

    return Column(
      children: [
        if (c.selectedAsset != 'Tools')
          _form(text, _textField(text, c.txtADetail3))
      ],
    );
  }

  _assetDetail4(c) {
    var text;
    (c.selectedAsset != null)
        ? (c.selectedAsset == 'Office Equipment')
            ? text = 'Kapasitas Penyimpanan'
            : (c.selectedAsset == 'Vehicle')
                ? text = 'Nomor Rangka'
                : text = ''
        : text = '';

    return Column(
      children: [
        if (c.selectedAsset != 'Tools')
          _form(text, _textField(text, c.txtADetail4))
      ],
    );
  }

  _assetDetail5(c) {
    var text;
    (c.selectedAsset != null)
        ? (c.selectedAsset == 'Office Equipment')
            ? text = ''
            : (c.selectedAsset == 'Vehicle')
                ? text = 'CC Mesin'
                : text = ''
        : text = '';

    return Column(
      children: [
        if (c.selectedAsset == 'Vehicle')
          _form(text, _textField(text, c.txtADetail5))
      ],
    );
  }

  _dropdown(c) {
    return Container(
      width: 260,
      child: MyDropdown(
        hint: 'Jenis Aset',
        selectValue: c.selectedAsset,
        listDropdown: c.lAssetType,
        onChanged: (value) => c.selectType(value),
      ),
    );
  }

  _textField(text, controller, {icon, r = false, k, i}) {
    return TextFormField(
      controller: controller,
      readOnly: r,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '*Wajib diisi ';
        }

        return null;
      },
      keyboardType: k,
      inputFormatters: i,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(fontSize: 14),
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xffA1616A)),
        ),
        suffixIcon: icon,
      ),
      cursorColor: Color(0xffA1616A),
    );
  }

  _myImage(image, {onTap}) {
    return InkWell(
      onTap: onTap,
      child: image == null
          ? Center(child: Icon(Icons.add_a_photo, size: 50))
          : Image.file(image!, fit: BoxFit.cover),
    );
  }

  _button({textButton, onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30),
      child: Container(
        margin: EdgeInsets.only(top: 30.0, bottom: 30),
        width: double.infinity,
        height: 45,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Color(0xffDF9A9A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            textButton,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
