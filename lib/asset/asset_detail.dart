import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asmen/get/asset.dart';
import 'package:asmen/get/url.dart';

import '../main.dart';

class AssetDetail extends StatelessWidget {
  final page = Get.arguments['page'];
  final data = Get.arguments['data'];
  final typeUser = gs.read('dataUser')['type_user'];
  late final typeAsset = data['asset_type'];

  @override
  Widget build(BuildContext context) {
    var period = (page == 'asset') ? ' tahun' : ' hari';
    var assetPeriod = (page == 'asset')
        ? data['asset_period'].toString() + period
        : data['asset_period_day'].toString() + period;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Asset", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xffA1616A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          (typeUser == 'Manager')
              ? Text('')
              : IconButton(
                  icon: Icon(Icons.delete, color: Colors.white, size: 30),
                  onPressed: () => AssetC.to.deleteAsset(
                    context,
                    data,
                    data['asset_id'],
                    data['asset_front_image'],
                    data['asset_back_image'],
                    page,
                  ),
                ),
        ],
      ),
      body: ListView(
        children: [
          MyCarousel(data: data),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data['asset_name'],
                  maxLines: 2,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 3, left: 3),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xffA1616A),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  _card(
                    icon: Icons.person,
                    text: 'User PIC',
                    value: data['asset_pic'],
                  ),
                  _divider(),
                  _card(
                    text: 'Jenis Aset',
                    value: data['asset_type'],
                    icon: Icons.assessment_rounded,
                  ),
                  _divider(),
                  _card(
                    text: 'Merk',
                    value: data['asset_brand'].toString(),
                    icon: Icons.branding_watermark_rounded,
                  ),
                  _divider(),
                  _card(
                    text: 'Lokasi',
                    value: data['asset_location'].toString(),
                    icon: Icons.place_rounded,
                  ),
                  _divider(),
                  _card(
                    text: 'Tanggal Terima',
                    value: data['asset_date'].toString(),
                    icon: Icons.calendar_today,
                  ),
                  _divider(),
                  _card(
                    text: 'Masa Aset',
                    value: assetPeriod,
                    icon: Icons.new_releases,
                  ),
                  _divider(),
                  _card(
                    text: 'Harga Perolehan',
                    value: data['asset_price'],
                    icon: Icons.price_change,
                  ),
                  if (typeAsset != 'Tools')
                    Column(
                      children: [
                        _divider(),
                        _card(
                          text: (typeAsset == 'Office Equipment')
                              ? 'Serial Number'
                              : 'Tahun Produksi',
                          value: data['asset_detail1'],
                          icon: (typeAsset == 'Office Equipment')
                              ? Icons.key_rounded
                              : Icons.build_rounded,
                        ),
                      ],
                    ),
                  if (typeAsset != 'Tools')
                    Column(
                      children: [
                        _divider(),
                        _card(
                          text: (typeAsset == 'Office Equipment')
                              ? 'Tipe Processor'
                              : 'Plat Nomor',
                          value: data['asset_detail2'],
                          icon: (typeAsset == 'Office Equipment')
                              ? Icons.info_rounded
                              : Icons.directions_car_rounded,
                        ),
                      ],
                    ),
                  if (typeAsset != 'Tools')
                    Column(
                      children: [
                        _divider(),
                        _card(
                          text: (typeAsset == 'Office Equipment')
                              ? 'RAM'
                              : 'Nomor Mesin',
                          value: data['asset_detail3'],
                          icon: (typeAsset == 'Office Equipment')
                              ? Icons.sync_problem_rounded
                              : Icons.precision_manufacturing_rounded,
                        ),
                      ],
                    ),
                  if (typeAsset != 'Tools')
                    Column(
                      children: [
                        _divider(),
                        _card(
                          text: (typeAsset == 'Office Equipment')
                              ? 'Kapasitas Penyimpanan'
                              : 'Nomor Rangka',
                          value: data['asset_detail4'],
                          icon: (typeAsset == 'Office Equipment')
                              ? Icons.storage_rounded
                              : Icons.confirmation_num_rounded,
                        ),
                      ],
                    ),
                  if (typeAsset == 'Vehicle')
                    Column(
                      children: [
                        _divider(),
                        _card(
                          text: 'CC Mesin',
                          value: data['asset_detail5'],
                          icon: Icons.filter_alt_rounded,
                        ),
                      ],
                    ),
                  SizedBox(height: 10),
                  if (page == 'asset' && typeUser != 'Manager') _button(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _card({icon, text, value, onTap}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        padding: const EdgeInsets.all(8),
        child: Material(
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(icon, size: 40, color: Colors.black),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(text),
                        const SizedBox(height: 5),
                        Text(value)
                      ],
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

  _divider() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        height: 5,
        decoration: BoxDecoration(color: Colors.white),
      ),
    );
  }

  _button() {
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
          onPressed: () async {
            await AssetC.to.handleDetail(data['asset_id']);
            await AssetC.to.updateAsset();
          },
          child: Text("Edit Aset", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class MyCarousel extends StatefulWidget {
  const MyCarousel({this.data});

  final Map? data;

  @override
  _MyCarouselState createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  int activeIndex = 0;
  var u = BaseURL.showImages;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          items: [
            Container(
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  onError: (e, stackTrace) {
                    Get.snackbar('Error', "can't load image");
                  },
                  image: NetworkImage(
                    u + widget.data!['asset_front_image'],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  onError: (e, stackTrace) {
                    Get.snackbar('Error', "can't load image");
                  },
                  image: NetworkImage(
                    u + widget.data!['asset_back_image'],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
          options: CarouselOptions(
            enlargeCenterPage: true,
            aspectRatio: 1.5,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            viewportFraction: 1,
            onPageChanged: (index, reason) =>
                setState(() => activeIndex = index),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 12.0,
              height: 12.0,
              margin: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 4.0,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (activeIndex == 0) ? Colors.grey[600] : Colors.grey[400],
              ),
            ),
            Container(
              width: 12.0,
              height: 12.0,
              margin: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 4.0,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (activeIndex == 1) ? Colors.grey[600] : Colors.grey[400],
              ),
            )
          ],
        ),
      ],
    );
  }
}
