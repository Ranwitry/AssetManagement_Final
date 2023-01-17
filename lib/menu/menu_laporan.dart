import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asmen/get/asset.dart';
import 'package:asmen/widget/common.dart';

class ReportMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssetC>(
      init: AssetC(),
      builder: (_) => MyScaffold(
        text: 'Laporan Aset',
        backButton: true,
        body: Column(
          children: [
            _asset(context),
            _assetPeriod(context),
          ],
        ),
      ),
    );
  }

  _container(context, {onTap, text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffA1616A),
          ),
          padding: const EdgeInsets.all(8),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(20),
              splashColor: Color(0xffDF9A9A),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.print,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _asset(context) {
    return _container(
      context,
      onTap: () => Get.toNamed('/report_print', arguments: 'asset'),
      text: 'Laporan Aset',
    );
  }

  _assetPeriod(context) {
    return _container(
      context,
      onTap: () => Get.toNamed('/report_print', arguments: 'period'),
      text: 'Laporan Masa Aset Habis',
    );
  }
}
