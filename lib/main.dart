import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:asmen/asset/asset_detail.dart';
import 'package:asmen/login/greetings_page.dart';
import 'package:asmen/login/logins_page.dart';
import 'package:asmen/menu/menu_aset.dart';
import 'package:asmen/menu/menu_utama.dart';
import 'package:asmen/splash.dart';
import 'package:asmen/user/list_user.dart';

import 'asset/data_pic.dart';
import 'asset/form_asset.dart';
import 'kategori/data_asset.dart';
import 'laporan/print_laporan.dart';
import 'menu/menu_laporan.dart';
import 'menu/menu_reminder.dart';
import 'user/profile.dart';

final gs = GetStorage();

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Asset Management',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: SplashPage(),
      routes: {
        '/login': (BuildContext context) => PageLogin(),
        '/greetings': (BuildContext context) => GreetingsPage(),
        '/menu': (BuildContext context) => MenuPage(),
        '/profile': (BuildContext context) => ProfilePage(),
        '/user': (BuildContext context) => DataUser(),
        '/setting': (BuildContext context) => ListUser(),
        '/asset': (BuildContext context) => AssetMenu(),
        '/reminder': (BuildContext context) => ReminderMenu(),
        '/report': (BuildContext context) => ReportMenu(),
        '/data_asset': (BuildContext context) => DataAsset(),
        '/asset_detail': (BuildContext context) => AssetDetail(),
        '/form_asset': (BuildContext context) => FormAsset(),
        '/report_print': (BuildContext context) => ReportPrintAsset(),
      },
    );
  }
}
