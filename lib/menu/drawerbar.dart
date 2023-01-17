import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asmen/get/report.dart';
import 'package:asmen/widget/alert.dart';

import '../get/asset.dart';
import '../get/login.dart';
import '../get/user.dart';
import '../main.dart';

class DrawerBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var i =
        'https://i.pinimg.com/564x/80/3b/04/803b045ff2f511ea3cde28210a2d9720.jpg';

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              gs.read('dataUser')['name_user'],
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              gs.read('dataUser')['email_user'],
              style: TextStyle(color: Colors.white),
            ),
            currentAccountPicture: Icon(
              Icons.account_circle,
              size: 80,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(i),
                fit: BoxFit.cover,
              ),
            ),
          ),
          _myListTile(
            'Profile',
            Icons.person,
            onTap: () => Get.toNamed('/profile'),
          ),
          if (gs.read('dataUser')['type_user'] == 'Super Admin') _divider(),
          if (gs.read('dataUser')['type_user'] == 'Super Admin')
            _myListTile(
              'Setting',
              Icons.settings,
              onTap: () => Get.toNamed('/setting'),
            ),
          _divider(),
          _myListTile(
            'Keluar',
            Icons.exit_to_app,
            onTap: () => myAlert(
              context,
              'Apakah anda yakin ingin keluar dari aplikasi ini?',
              onPressed: () {
                gs.erase();
                Get.delete<AssetC>();
                Get.delete<UserC>();
                Get.delete<LoginC>();
                Get.delete<ReportC>();
                Get.offAllNamed('/login');
              },
            ),
          ),
        ],
      ),
    );
  }

  _myListTile(text, icon, {onTap}) {
    return ListTile(
      leading: Icon(icon),
      tileColor: Color(0xffEAECEE),
      title: Text(text),
      onTap: onTap,
    );
  }

  _divider() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        height: 5,
        decoration: BoxDecoration(color: Color(0xffDF9A9A)),
      ),
    );
  }
}
