import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asmen/main.dart';

class GreetingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.asset("images/iconn.png"),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Text(
                  "HALO, ${gs.read('dataUser')['name_user']}!",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                "Selamat datang di Aplikasi Asset Management",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 50, right: 50),
              child: ElevatedButton(
                onPressed: () => Get.offNamed('/menu'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffDF9A9A),
                  onPrimary: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Ketuk untuk lanjut'),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_right_outlined, size: 24.0),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
