import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportC extends GetxController {
  static ReportC get to => Get.find();
  DateTime dateNow = DateTime.now();

  final TextEditingController dateStart = TextEditingController();
  final TextEditingController dateEnd = TextEditingController();

  List lReportAsset = [];
  String page = 'asset';

  var txtDateStart;
  var txtDateEnd;

  pickedDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: dateNow,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    return _pickedDate;
  }
 
  selectDate(BuildContext context, value) async {
    if (value == 'start') {
      txtDateStart = await pickedDate(context);
      dateStart.text = DateFormat('yyyy-MM-dd').format(txtDateStart);
      return;
    } else {
      txtDateEnd = await pickedDate(context);
    }
 
    if (txtDateEnd.isAfter(txtDateStart)) {
      dateEnd.text = DateFormat('yyyy-MM-dd').format(txtDateEnd);
    } else {
      Get.snackbar('Error', 'Tanggal Akhir lebih kecil dari Tanggal Awal');
    }
  }

  //  selectDate(BuildContext context, value) async {
  //   DateTime txtDateStart = DateTime.now();
  //   DateTime txtDateEnd = DateTime.now();
  //   var _pickedDate = await showDatePicker(
  //     initialEntryMode: DatePickerEntryMode.calendarOnly,
  //     context: context,
  //     initialDate: dateNow,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //   );
 
  //   if (_pickedDate != null) {
  //     if (value == 'start') {
  //       txtDateStart = _pickedDate;
  //       dateStart.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
  //     } else {
  //       txtDateEnd = _pickedDate;
  //       if (txtDateEnd.isAfter(txtDateStart)) {
  //         dateEnd.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
  //       } else {
  //         Get.snackbar('Error', 'Tanggal Akhir lebih kecil dari Tanggal Awal');
  //       }
  //     }
  //   }
  // }

  // selectDate(BuildContext context, value) async {
  //   var _pickedDate = await showDatePicker(
  //     initialEntryMode: DatePickerEntryMode.calendarOnly,
  //     context: context,
  //     initialDate: dateNow,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //   );

  //   if (_pickedDate != null) {
  //     if (value == 'start') {
  //       dateStart.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
  //     } else {
  //       dateEnd.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
  //     }
  //   }
  // }

  viewReport(value, data, type, page) async {
    if (dateStart.text != '' && dateEnd.text != '') {
      lReportAsset.clear();
      await createListReport(value, data);
      if (lReportAsset.isNotEmpty) {
        await createPdf(type, page);
      } else {
        Get.snackbar('Error', 'Data Tidak Ditemukan');
      }
    } else {
      Get.snackbar('Error', 'Pilih tanggal terlebih dahulu');
    }
  }

  createListReport(value, data) {
    var a = dateStart.text;
    var b = DateTime.parse(a);
    var c = dateEnd.text;
    var d = DateTime.parse(c);
    var lReport = value;

    for (var i = 0; i < lReport.length; i++) {
      var date = DateTime.parse(lReport[i]['asset_date']);
      if (b.isBefore(date) && d.isAfter(date)) {
        data.add(lReport[i]);
      }
    }
  }

  createPdf(type, page) async {
    final pdf = pw.Document();
    var date = dateStart.text + ' s.d ' + dateEnd.text;
    pdf.addPage(
      pw.Page(
        orientation: pw.PageOrientation.landscape,
        build: (pw.Context context) {
          return pw.Column(
          children: [
              pw.Text(
                (page == 'asset')
                    ? 'LAPORAN ASET MASUK PERUSAHAAN ' + date
                    : 'LAPORAN ASET MASA HABIS PERUSAHAAN ' + date,
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(2),
                        child: pw.Text(
                          'No',
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text(
                          'Asset ID',
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text(
                          'Nama Aset',
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text(
                          'Merk',
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text(
                          'Tanggal Terima',
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      if (page == 'period')
                        pw.Padding(
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text(
                            'Tanggal Habis',
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text(
                          'PIC Aset',
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text(
                          'Masa Aset',
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text(
                          'Harga Perolehan',
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.ListView(
                        children: lReportAsset.map((dt) {
                          var i = lReportAsset.indexOf(dt);
                          return pw.Text((i + 1).toString());
                        }).toList(),
                      ),
                      pw.ListView(
                        children: lReportAsset.map((dt) {
                          return pw.Text(
                            (page == 'asset')
                                ? dt['asset_id'].toString()
                                : dt['asset_expires_id'].toString(),
                            textAlign: pw.TextAlign.center,
                          );
                        }).toList(),
                      ),
                      pw.ListView(
                        children: lReportAsset.map((dt) {
                          return pw.Text(
                            dt['asset_name'],
                            textAlign: pw.TextAlign.center,
                          );
                        }).toList(),
                      ),
                      pw.ListView(
                        children: lReportAsset.map((dt) {
                          return pw.Text(
                            dt['asset_brand'],
                            textAlign: pw.TextAlign.center,
                          );
                        }).toList(),
                      ),
                      pw.ListView(
                        children: lReportAsset.map((dt) {
                          var aa = DateTime.parse(dt['asset_date']);
                          var a = aa.toLocal();
                          var date = DateFormat('yyyy-MM-dd').format(a);
                          return pw.Text(date);
                        }).toList(),
                      ),
                      if (page == 'period')
                        pw.ListView(
                          children: lReportAsset.map((dt) {
                            var a = dt['asset_date'];
                            var b = DateTime.parse(a);
                            int c = int.parse(dt['asset_period']);
                            int f = b.year;
                            int g = f + c;
                            return pw.Text('$g-${b.month}-${b.day}');
                          }).toList(),
                        ),
                      pw.ListView(
                        children: lReportAsset.map((dt) {
                          return pw.Text(
                            dt['asset_pic'],
                            textAlign: pw.TextAlign.center,
                          );
                        }).toList(),
                      ),
                      pw.ListView(
                        children: lReportAsset.map((dt) {
                          return pw.Text(dt['asset_period'].toString());
                        }).toList(),
                      ),
                      pw.ListView(
                        children: lReportAsset.map((dt) {
                          return pw.Text(dt['asset_price']);
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ); // Center
        },
      ),
    );

    final bytes = await pdf.save();

    final dir = await getExternalStorageDirectory();
    final file = File('${dir!.path}/$page $date.pdf');
    await file.writeAsBytes(bytes);

    if (type == 'view') {
      await OpenFile.open('${dir.path}/$page $date.pdf');
    } else {
      print(file);
      Get.snackbar('Success', 'Berhasil Simpan Data di $file');
    }
  }
}
