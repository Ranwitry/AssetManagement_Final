import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataUser extends StatelessWidget {
  final Map dt = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: <Widget>[_top(), _body(context)]));
  }

  _top() {
    return Stack(
      children: [
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            height: 150,
            decoration: BoxDecoration(color: Color(0xffA1616A)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25, left: 5),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 50,
            color: Colors.white,
            onPressed: () => Get.back(),
          ),
        ),
      ],
    );
  }

  _body(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.65,
        margin: EdgeInsets.only(top: 28.0),
        decoration: BoxDecoration(
          color: Color(0xffececec),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _picture(),
                _form('Name', dt['name_user']),
                // if (dt['username'] != null) _form('Username', dt['username']),
                _form('Email', dt['email_user']),
                // if (dt['password_user'] != null) _form('Password', dt['password_user']),
                _form('Phone Number', dt['phone_number_user']),
                _form('Jabatan', dt['jabatan_user']),
                // if (dt['type_user'] != null) _form('Password', dt['type_user']),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _picture() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Center(
            child: Text(
              "Data User",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: "Nunito",
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Icon(Icons.account_circle, size: 110, color: Colors.black),
        ),
      ],
    );
  }

  _form(text, value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10, left: 18),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: "NunitoSans",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(3.0),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffA1616A)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(value, style: TextStyle(fontFamily: "Nunito")),
            ),
          ),
        ),
      ],
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - 40);
    var controllPoint = Offset(50, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
