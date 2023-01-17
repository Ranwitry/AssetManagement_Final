import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asmen/get/asset.dart';

import 'drawerbar.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Asset Management',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xffA1616A),
      ),
      drawer: DrawerBar(),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Color(0xffA1616A)),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                _assets(),
                _reminder(),
                _report(),
              ],
            ),
          )
        ],
      ),
    );
  }

  _cont(icon, text, {onPressed, count}) {
    return Container(
      height: 120,
      width: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          splashColor: Color(0xffA1616A),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(icon, size: 70),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      maxLines: 4,
                    ),
                    if (count != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Jumlah: $count",
                          style: TextStyle(fontFamily: "Nunito"),
                        ),
                      )
                  ],
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, size: 35)
            ],
          ),
        ),
      ),
    );
  }

  _assets() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 25, left: 25),
      child: _cont(
        Icons.bar_chart,
        'Assets',
        onPressed: () => Get.toNamed('/asset'),
      ),
    );
  }

  _reminder() {
    return Padding(
      padding: const EdgeInsets.only(top: 60, right: 25, left: 25, bottom: 10),
      child: GetBuilder<AssetC>(
        init: AssetC(),
        builder: (a) => _cont(
          Icons.warning_rounded,
          'Reminder Asset',
          count: a.lReminder.length,
          onPressed: () => Get.toNamed('/reminder'),
        ),
      ),
    );
  }

  _report() {
    return Padding(
      padding: const EdgeInsets.only(top: 60, right: 25, left: 25, bottom: 10),
      child: _cont(
        Icons.bar_chart,
        'Report',
        onPressed:  () => Get.toNamed('/report'),
      ),
    );
  }
}
