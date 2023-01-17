import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:asmen/main.dart';
import 'package:asmen/validation.dart';
import 'package:asmen/widget/dropdown.dart';

import '../get/user.dart';

class ProfilePage extends StatelessWidget {
  final page = Get.arguments;
  final typeUsr = gs.read('dataUser')['type_user'];
  final user = gs.read('dataUser')['username'];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserC>(
      init: UserC(),
      builder: (_) => Scaffold(
        backgroundColor: Color(0xffEAECEE),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _top(),
              _form(),
              _button(),
            ],
          ),
        ),
      ),
    );
  }

  _top() {
    return Stack(
      children: [
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: Color(0xffA1616A),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 50,
                color: Colors.white,
                onPressed: () => Get.back(),
              ),
              (typeUsr != 'Super Admin' ||
                      user == UserC.to.txtUsername.text ||
                      page == 'add')
                  ? Text('')
                  : IconButton(
                      icon: Icon(Icons.delete),
                      iconSize: 50,
                      color: Colors.white,
                      onPressed: () => UserC.to.handleDelete(),
                    )
            ],
          ),
        ),
      ],
    );
  }

  _myColumn(text, controller, {r = false, o = false, hide = false, v, k, i}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 25, left: 18),
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
          padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: TextFormField(
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            readOnly: r,
            obscureText: o,
            validator: v,
            keyboardType: k,
            inputFormatters: i,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xffA1616A)),
              ),
              suffixIcon: (hide != false)
                  ? IconButton(
                      onPressed: () => UserC.to.showHide(),
                      icon: Icon(
                        UserC.to.secureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    )
                  : Text(''),
            ),
          ),
        ),
      ],
    );
  }

  _form() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: (UserC.to.dataUser.isNotEmpty)
                ? Form(key: UserC.to.keyUser, child: _column())
                : Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }

  _column() {
    print(UserC.to.txtTypeUser.text != '');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Icon(Icons.account_circle, size: 100),
        ),
        _myColumn('Name', UserC.to.txtName, v: (v) => emptyValue(v)),
        _myColumn(
          'Username',
          UserC.to.txtUsername,
          r: (page != 'add') ? true : false,
          v: (v) => emptyValue(v),
        ),
        _myColumn(
          'Email',
          UserC.to.txtEmail,
          v: (v) => validateEmail(v),
        ),
        _myColumn(
          'Password',
          UserC.to.txtPass,
          o: UserC.to.secureText,
          hide: true,
          v: (v) => valueMustBe6(v),
        ),
        _myColumn(
          'Phone Number',
          UserC.to.txtPhone,
          k: TextInputType.number,
          i: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          v: (v) => emptyValue(v),
        ),
        _myColumn(
          'Jabatan',
          UserC.to.txtPosition,
          r: (page != 'add') ? true : false,
          v: (v) => emptyValue(v),
        ),
        (UserC.to.txtTypeUser.text == '')
            ? Padding(
                padding: EdgeInsets.all(20),
                child: MyDropdown(
                  hint: 'Type User',
                  selectValue: UserC.to.selectedType,
                  listDropdown: UserC.to.typeUser,
                  onChanged: (value) => UserC.to.selectType(value),
                ),
              )
            : _myColumn('Type User', UserC.to.txtTypeUser, r: true)
      ],
    );
  }

  _button() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 30, right: 20, bottom: 10),
      child: Container(
        width: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Color(0xffDF9A9A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () => (UserC.to.user == null)
              ? UserC.to.handleAdd()
              : UserC.to.handleUpdate(),
          child: Text(
            (UserC.to.user == null) ? 'Add' : 'Edit',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
