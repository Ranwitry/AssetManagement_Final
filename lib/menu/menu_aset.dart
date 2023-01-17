import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asmen/get/asset.dart';
import 'package:asmen/main.dart';

class AssetMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Asset Management',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xffA1616A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        children: [
          _tools(),
          _electronic(),
          _vehicle(),
        ],
      ),
      floatingActionButton: (gs.read('dataUser')['type_user'] != 'Manager')
          ? FloatingActionButton(
              backgroundColor: Color(0xffA1616A),
              onPressed: () {
                AssetC.to.txtSearch.clear();
                AssetC.to.txtId.clear();
                AssetC.to.txtUName.clear();
                AssetC.to.txtAName.clear();
                AssetC.to.txtABrand.clear();
                AssetC.to.txtALocation.clear();
                AssetC.to.txtADate.clear();
                AssetC.to.txtAPeriod.clear();
                AssetC.to.txtAPrice.clear();
                AssetC.to.txtADetail1.clear();
                AssetC.to.txtADetail2.clear();
                AssetC.to.txtADetail3.clear();
                AssetC.to.txtADetail4.clear();
                AssetC.to.txtADetail5.clear();
                AssetC.to.selectedAsset = null;
                Get.toNamed('/form_asset', arguments: 'add');
              },
              child: Icon(Icons.add_outlined),
            )
          : Text(''),
    );
  }

  _cont({onPressed, icon, text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 25, left: 25),
      child: Container(
        height: 120,
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade200,
        ),
        padding: const EdgeInsets.all(8),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(20),
            splashColor: Color(0xffA1616A),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(icon, size: 70),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Nunito",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "Klik untuk lebih lanjut!",
                          style: TextStyle(fontFamily: "Nunito"),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _tools() {
    return _cont(
      onPressed: () async {
        await AssetC.to.setData('Tools');
        Get.toNamed('/data_asset', arguments: 'Tools');
      },
      icon: Icons.home_work_sharp,
      text: 'Tools',
    );
  }

  _electronic() {
    return _cont(
      onPressed: () async {
        await AssetC.to.setData('Office Equipment');
        Get.toNamed('/data_asset', arguments: 'Office Equipment');
      },
      icon: Icons.laptop_mac_outlined,
      text: 'Office Equipment',
    );
  }

  _vehicle() {
    return _cont(
      onPressed: () async {
        await AssetC.to.setData('Vehicle');
        Get.toNamed('/data_asset', arguments: 'Vehicle');
      },
      icon: Icons.directions_car,
      text: 'Vehicle',
    );
  }
}
