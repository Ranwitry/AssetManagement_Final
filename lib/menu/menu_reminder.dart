import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asmen/get/asset.dart';
import 'package:asmen/get/url.dart';
import 'package:asmen/main.dart';

class ReminderMenu extends StatelessWidget {
  final typeUsr = gs.read('dataUser')['type_user'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder Asset', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xffA1616A),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 40, right: 25, left: 25, bottom: 10),
        child: GetBuilder<AssetC>(
          init: AssetC(),
          builder: (a) => ListView.builder(
            itemCount: a.lReminder.length,
            itemBuilder: ((c, i) {
              var dt = a.lReminder[i];
              return _card(dt, context);
            }),
          ),
        ),
      ),
    );
  }

  _card(dt, context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade200,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: () => Get.toNamed(
              '/asset_detail',
              arguments: {'page': 'reminder', 'data': dt},
            ),
            borderRadius: BorderRadius.circular(20),
            splashColor: Color(0xffA1616A),
            child: Row(
              children: [
                _image(dt),
                _body(dt),
                if (typeUsr != 'Manager') _delete(context, dt),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _image(dt) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Image.network(
          BaseURL.showImages + dt['asset_front_image'],
          fit: BoxFit.cover,
          errorBuilder: (context, exception, stackTrace) {
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  _body(dt) {
    return Expanded(
      flex: 7,
      child: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dt['asset_name'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Nunito",
              ),
              maxLines: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "Masa Aset " + dt['asset_period_day'].toString() + ' hari',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _delete(context, dt) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18, right: 5),
        child: IconButton(
          onPressed: () => AssetC.to.deleteReminder(context, dt),
          icon: Icon(Icons.cancel_rounded, size: 40),
        ),
      ),
    );
  }
}
