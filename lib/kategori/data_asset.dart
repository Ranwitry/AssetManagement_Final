import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asmen/get/url.dart';
import 'package:asmen/widget/common.dart';

import '../get/asset.dart';

class DataAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssetC>(
      init: AssetC(),
      builder: (a) {
        return Scaffold(
          backgroundColor: Colors.grey[350],
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Asset ${Get.arguments}",
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color(0xffA1616A),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              children: [
                MyTextFormField(
                  controller: a.txtSearch,
                  hintText: 'Search',
                  onFieldSubmitted: (value) => a.handleSearch(value),
                  // onChanged: (value) => a.handleSearch(value),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    itemCount: a.dtAsset.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 210,
                    ),
                    itemBuilder: (c, i) => _body(a.dtAsset[i]),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _body(dt) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 4,
          color: Color(0xffA1616A),
        ),
      ),
      child: Material(
        child: InkWell(
          onTap: () {
            Get.toNamed(
              '/asset_detail',
              arguments: {'page': 'asset', 'data': dt},
            );
          },
          borderRadius: BorderRadius.circular(20),
          splashColor: Color(0xffA1616A),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      onError: (e, stackTrace) {
                        Get.snackbar('Error', "can't load image");
                      },
                      image: NetworkImage(
                        BaseURL.showImages + dt['asset_front_image'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 5),
                child: Text(
                  dt['asset_name'],
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
