import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import '../tool/api.dart';
import '../../tool/color.dart'; 
import '../../tool/pref.dart';
import '../../tool/screen.dart';
import '../../tool/url.dart';
import '../../ui/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'MainMenu.dart';
import 'MainRouteHome.dart';

class ListDataRegister extends StatefulWidget {
  _ListDataRegister createState() => _ListDataRegister();
}

class _ListDataRegister extends State<ListDataRegister> {
  int _radioValue = 0;
  late DateTime _dateTime;
  var dateMessage = "";
  TextEditingController txtAge = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  var uuid = Uuid().v4(); // Generate a random UUID
  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();

  }

  void Rigister() async {
      Map<String, dynamic> data = {
        "uuid": uuid,
        "fcm_token":AppUrl.FCM_token
      };
      print(data);
      sendRigisterData(context, data);
  }
  void sendRigisterData(context, Map<String, dynamic> data) async {
    final response =await AppApi.post_String(AppUrl.register_safe_alert, data); // เรียกใช้ api
    print(response);
    if (response != "") {
      try{
        var registerId = int.parse(response);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('register_id',registerId.toString());
        AppUrl.RegisterID = registerId.toString();
        Navigator.pop(context);
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) {
              return MainRouteHome();
            }));
      }catch(e){
        print(e);
      }
    }
  }

  void _generateNewUuid() {
    setState(() {
      uuid = Uuid().v4(); // Generate a new random UUID
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
    child:
    Scaffold(
        appBar: null,
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(

        ),
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        margin: EdgeInsets.only(top: 100.0),
        child: Column(
          children: [
            Center(
              child: Text(
                  "ยินดีต้อนรับ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontFamily: 'SukhumvitSet-Bold'),
                  textAlign: TextAlign.center
              ),
            ),
            Expanded(
              flex: 5,
              child:
                  Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
            ),
            Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: 50.0,bottom: 50,left: 10,right: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        margin: EdgeInsets.only(right: 5),
                        width: double.maxFinite,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFFF9671),
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10.0, left: 20, right: 20),
                            backgroundColor: AppColors.colorMain,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                            elevation: 15.0,
                          ),
                          onPressed: () {
                            // Navigator.push(context,
                            //     CupertinoPageRoute(builder: (context) {
                            //       return MainMenu();
                            //     }));
                            FocusScopeNode currentFocus = FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            Rigister();

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  "เริ่มต้นใช้งาน",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 35,
                                      fontFamily: 'SukhumvitSet-Bold'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}