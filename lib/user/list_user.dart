import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../get/user.dart';

class ListUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan User'),
        backgroundColor: Color(0xffA1616A),
      ),
      body: GetBuilder<UserC>(
        init: UserC(),
        builder: (u) => (u.lUser.isNotEmpty)
            ? ListView.builder(
                itemCount: u.lUser.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    color: Colors.grey.shade200,
                    elevation: 5,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    child: InkWell(
                      child: ListTile(
                        leading: Icon(
                          Icons.account_circle_rounded,
                          size: 50,
                          color: Colors.black,
                        ),
                        title: Text(
                          u.lUser[index]['name_user'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: "NunitoSans",
                          ),
                        ),
                      ),
                      onTap: () => u.goDetail(u.lUser[index]['username']),
                    ),
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffA1616A),
        onPressed: () => UserC.to.addUser(),
        child: Icon(Icons.add_outlined),
      ),
    );
  }
}
