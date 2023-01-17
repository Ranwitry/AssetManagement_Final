import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asmen/get/asset.dart';
import 'package:asmen/get/report.dart';

class ReportPrintAsset extends StatelessWidget {
  final page = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (page == 'asset') ? 'Laporan Aset' : 'Laporan Masa Asset Habis',
        ),
        backgroundColor: Color(0xffA1616A),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _title(),
            _body(context),
            const SizedBox(height: 40),
            _button(
              text: 'Lihat Laporan',
              icon: Icons.search,
              onPressed: () {
                ReportC.to.viewReport(
                  (page == 'asset')
                      ? AssetC.to.lAsset
                      : AssetC.to.lAssetExpires,
                  ReportC.to.lReportAsset,
                  'view',
                  page,
                );
              },
            ),
            const SizedBox(height: 20),
            _button(
              text: 'Unduh Laporan',
              icon: Icons.download,
              onPressed: () {
                ReportC.to.viewReport(
                  (page == 'asset')
                      ? AssetC.to.lAsset
                      : AssetC.to.lAssetExpires,
                  ReportC.to.lReportAsset,
                  'download',
                  page,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _title() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 25),
      child: Text(
        "Jangka Waktu",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _form({text, controller, onPressed}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          child: TextFormField(
            readOnly: true,
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '*Wajib diisi ';
              }

              return null;
            },
            cursorColor: Color(0xffA1616A),
            decoration: InputDecoration(
              hintText: "Pilih Tanggal",
              hintStyle: TextStyle(fontSize: 14),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.date_range,
                  size: 30,
                  color: Color(0xffA1616A),
                ),
                onPressed: onPressed,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xffA1616A)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _body(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: GetBuilder<ReportC>(
        init: ReportC(),
        builder: (r) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _form(
              text: 'Tanggal Awal',
              controller: r.dateStart,
              onPressed: () => r.selectDate(context, 'start'),
            ),
            const SizedBox(height: 30),
            _form(
              text: 'Tanggal Akhir',
              controller: r.dateEnd,
              onPressed: () => r.selectDate(context, 'end'),
            )
          ],
        ),
      ),
    );
  }

  _button({text, icon, onPressed}) {
    return Center(
      child: Container(
        width: 200,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(text, style: TextStyle(fontSize: 14)),
          style: ElevatedButton.styleFrom(
            primary: Color(0xffDF9A9A),
            onPrimary: Colors.white,
          ),
        ),
      ),
    );
  }
}
