import 'dart:convert';
import 'dart:io';
import 'dart:io';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:alarm/alarm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../model/ModelNotification.dart';
import '../../tool/api.dart';
import '../../tool/color.dart'; 
import '../../tool/loader.dart';
import '../../tool/screen.dart';
import '../../tool/url.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as Io;

import '../../main.dart';
import 'TypeMedicine.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:http/http.dart' as http;

class AddImageMedicine extends StatefulWidget {
  AddImageMedicine();
  @override
  _AddImageMedicine createState() => _AddImageMedicine();
}

class _AddImageMedicine extends State<AddImageMedicine> {
  AlarmSettings? alarmSettings;
  TextEditingController txtMedicine = TextEditingController();

  late DateTime _dateTime;
  late TimeOfDay _time;

  // @override
  // void initState() {
  //   _dateTime = DateTime.now();
  //   _time = TimeOfDay(hour: TimeOfDay
  //       .now()
  //       .hour, minute: TimeOfDay
  //       .now()
  //       .minute + 2);
  //   super.initState();
  // }

  int _selectedIndex = -1;
  File fileImg = File('');
  bool loading = false;
  var  img64 = "";
  late bool creating;
  late TimeOfDay selectedTime;
  late bool loopAudio;
  late bool vibrate;
  late bool volumeMax;
  late bool showNotification = false;
  late String assetAudio;

  bool isToday() {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
      0,
      0,
    );

    return now.isBefore(dateTime);
  }

  @override
  void initState() {
    super.initState();
    Alarm.init();
      _dateTime = DateTime.now();
      _time = TimeOfDay(hour: TimeOfDay
          .now()
          .hour, minute: TimeOfDay
          .now()
          .minute);
    creating = alarmSettings == null;

    if (creating) {
      final dt = DateTime.now().add(const Duration(minutes: 1));
      selectedTime = TimeOfDay(hour: dt.hour, minute: dt.minute);
      loopAudio = true;
      vibrate = true;
      volumeMax = true;
      // showNotification = true;
      assetAudio = 'assets/marimba.mp3';
    } else {
      selectedTime = TimeOfDay(
        hour: alarmSettings!.dateTime.hour,
        minute: alarmSettings!.dateTime.minute,
      );
      loopAudio = alarmSettings!.loopAudio;
      vibrate = alarmSettings!.vibrate;
      volumeMax = alarmSettings!.volumeMax;
      showNotification = alarmSettings!.notificationTitle != null &&
          alarmSettings!.notificationTitle!.isNotEmpty &&
          alarmSettings!.notificationBody != null &&
          alarmSettings!.notificationBody!.isNotEmpty;
      assetAudio = alarmSettings!.assetAudioPath;
    }
  }

  Future<void> pickTime() async {
    final res = await showTimePicker(
      initialTime: selectedTime,
      context: context,
    );
    if (res != null) setState(() => selectedTime = res);
  }

  AlarmSettings buildAlarmSettings() {
    final now = DateTime.now();
    final id = DateTime.now().millisecondsSinceEpoch % 100000;

    DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
      0,
      0,
    );
    if (dateTime.isBefore(DateTime.now())) {
      dateTime = dateTime.add(const Duration(days: 1));
    }

    final alarmSettings = AlarmSettings(
      id: id,
      dateTime: dateTime,
      loopAudio: loopAudio,
      vibrate: vibrate,
      volumeMax: volumeMax,
      notificationTitle: showNotification ? 'แจ้งเตือนทานยา' : null,
      notificationBody: showNotification ? 'เวลาที่ทานยา 18.00 วันนี้' : null,
      assetAudioPath: assetAudio,
      stopOnNotificationOpen: false,
    );
    return alarmSettings;
  }

  void saveAlarm() {
    setState(() => loading = true);
    Alarm.set(alarmSettings: buildAlarmSettings()).then((res) {
      if (res) Navigator.pop(context, true);
    });
    setState(() => loading = false);
  }

  void deleteAlarm() {
    Alarm.stop(alarmSettings!.id).then((res) {
      if (res) Navigator.pop(context, true);
    });
  }

  Future<void> uploadImage(medicineId) async {
    //show your own loading or progressing code here

    var uploadurl = Uri.parse(AppUrl.upload_img_medicine);
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    try{
      List<int> imageBytes = fileImg.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      //convert file image to Base64 encoding
      var response = await http.post(
          uploadurl,
          body: {
            'image': baseimage,
            'medicineId':medicineId
          }
      );
      if(response.statusCode == 200){
        var jsondata = json.decode(response.body); //decode json data
        if(jsondata["error"]){ //check error sent from server
          print(jsondata["msg"]);
          //if error return from server, show message from server
        }else{
          print("Upload successful");
        }
      }else{
        print("Error during connection to server");
        //there is error during connecting to server,
        //status code might be 404 = url not found
      }
    }catch(e){
      print("Error during converting to Base64");
      //there is error during converting file image to base64 encoding.
    }
    AppLoader.hide();
  }
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery
        .of(context)
        .viewInsets
        .bottom != 0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: ImageIcon(
            AssetImage("assets/images/arrow_left.png"),
            size: 40,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        width: double.maxFinite,
        height: double.maxFinite,
        child: ListView(
            children: [
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(20),
                            width: double.maxFinite,
                            child: Text("กรุณาเพิ่มรูปยาและฉลากยา",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 40,
                                    fontFamily: 'SukhumvitSet-Bold'),
                                textAlign: TextAlign.center),
                          ),
                          InkWell(
                            onTap: () {
                              _openPopupAddImage(context);
                            },
                            child: fileImg.path == "" ?
                            Image.asset(
                              'assets/images/ic_image.png',
                              width: 150, height: 150,) :
                            Image.file(fileImg,
                              width: 150, height: 150,),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 20, left: 10, right: 10),
                            padding: EdgeInsets.only(left: 15.0, right: 15.0),
                            width: double.maxFinite,
                            child: TextField(
                              autofocus: true,
                              controller: txtMedicine,
                              enabled: true,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontFamily: 'SukhumvitSet-Bold',
                                  color: Colors.black),
                              decoration: new InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15),
                                  //ปรับตำแหน่งcursor เริ่มต้นในช่องข้อความ
                                  border: new OutlineInputBorder(
                                      borderRadius:
                                      const BorderRadius.all(
                                        const Radius.circular(20.0),
                                      ),
                                      borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none)),
                                  filled: true,
                                  hintText: "ฉลากยา : ",
                                  hintStyle: new TextStyle(
                                      fontFamily: 'SukhumvitSet-Medium',
                                      color: Colors.grey[800]),
                                  fillColor: AppColors.bgColor),
                              // fillColor: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ]),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: Container(
          height: 60,
          margin: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(right: 5),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.only(
                            left: 5, right: 5, top: 10, bottom: 10),),
                      shape: MaterialStateProperty.resolveWith((states) =>
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),)),
                      backgroundColor: MaterialStateProperty.resolveWith((
                          states) => AppColors.colorMain),
                      elevation: MaterialStateProperty.resolveWith<double>(
                            (Set<MaterialState> states) {
                          return 2.0;
                        },),
                    ),
                    onPressed: () {
                      // Navigator.push(context,
                      //     CupertinoPageRoute(builder: (context) {
                      //       return MainMenu();
                      //     }));
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "ย้อนกลับ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily:
                                'SukhumvitSet-Bold'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(left: 5),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.only(
                            left: 5, right: 5, top: 10, bottom: 10),),
                      shape: MaterialStateProperty.resolveWith((states) =>
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),)),
                      backgroundColor: MaterialStateProperty.resolveWith((
                          states) => AppColors.colorMain),
                      elevation: MaterialStateProperty.resolveWith<double>(
                            (Set<MaterialState> states) {
                          return 2.0;
                        },),
                    ),
                    onPressed: () async {
                      if (txtMedicine.text != "" && img64.isNotEmpty) {
                        AppLoader.show();
                        var alertId = 5555;
                        DateTime dateTemp = DateTime(
                            _dateTime.year,
                            _dateTime.month,
                            _dateTime.day,
                            _time.hour,
                            _time.minute);
                        var strNameTitle = AppUrl.objAddItemMedicine
                            .nameMedicine.toString();
                        var notification = ModelNotification(
                            messageDateTime: strNameTitle,
                            dateTime: dateTemp,
                            name: "ชื่อยา : ${AppUrl.objAddItemMedicine
                                .nameMedicine}");


                        Map<String, dynamic> data = {
                          "register_id": AppUrl.RegisterID,
                          "medicine_name": AppUrl.objAddItemMedicine
                              .nameMedicine,
                          "time_take_id": AppUrl.objAddItemMedicine.timeTakeId,
                          "type_medicine_id": AppUrl.objAddItemMedicine
                              .typeMedicineId,
                          "type_medicine_name": AppUrl.objAddItemMedicine
                              .typeMedicineName,
                          "amount_unit_sub": AppUrl.objAddItemMedicine
                              .amountPerMedicine,
                          "unit_sub_id": AppUrl.objAddItemMedicine
                              .unitSubMedicineId,
                          "amount_unit_all": AppUrl.objAddItemMedicine
                              .amountPerMedicineAll,
                          "unit_all_id": AppUrl.objAddItemMedicine
                              .unitMedicineAllId,
                          "period_id": AppUrl.objAddItemMedicine.periodId,
                          "start_date": AppUrl.objAddItemMedicine
                              .startDateMedicine,
                          "time_day_id": AppUrl.objAddItemMedicine.timeDayId,
                          "label_medicine": AppUrl.objAddItemMedicine
                              .labelMedicine,
                        };
                          // ModelSetAlarm.saveData(context, data);
                          final response = await AppApi.post_Json(
                              AppUrl.insert_medicine, data); // เรียกใช้ api
                          print(response);
                          if (response['statusCode'] == 200) {
                            if (response['medicine_id']
                                .toString()
                                .isNotEmpty) {
                              var medicineId = response['medicine_id']
                                  .toString();
                                  uploadImage(medicineId);
                              for (var i = 0; i <
                                  AppUrl.objAddItemMedicine.timeNum
                                      .length; i++) {
                                var msgTimeAlarm = "เวลาที่ทานยา ${AppUrl
                                    .objAddItemMedicine.timeNum[i]} วันนี้";
                                var msgNumMedicine = "ทาน ${AppUrl
                                    .objAddItemMedicine
                                    .amountPerMedicine} ${AppUrl
                                    .objAddItemMedicine.unitSubMedicineName}";
                                String datetimeMedicine =
                                DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .format(dateTemp);
                                Map<String, dynamic> data = {
                                  "register_id": AppUrl.RegisterID,
                                  "msg_time_alarm": msgTimeAlarm,
                                  "msg_num_medicine": msgNumMedicine,
                                  "set_time_alarm": AppUrl.objAddItemMedicine
                                      .timeNum[i],
                                  "start_date_alarm": AppUrl.objAddItemMedicine
                                      .startDateMedicine,
                                  "msg_skip": "ไม่ได้ทานยา",
                                  "num_skip": 0,
                                  "medicine_id": medicineId,
                                  "period_id": AppUrl.objAddItemMedicine
                                      .periodId,

                                };
                                final response = await AppApi.post_Json(
                                    AppUrl.insert_alarm, data); // เรียกใช้ api
                                print(response);
                                if (response['statusCode'] == 200) {
                                  var dateAlarm = "${AppUrl.objAddItemMedicine
                                      .startDateMedicine} ${AppUrl
                                      .objAddItemMedicine.timeNum[i]}";
                                  DateTime datetimeMedicine = DateTime.parse(
                                      dateAlarm);
                                  // final alarmSettings = AlarmSettings(
                                  //   id: 42,
                                  //   dateTime: datetimeMedicine,
                                  //   assetAudioPath: 'assets/marimba.mp3',
                                  //   volumeMax: false,
                                  // );
                                  // Alarm.set(alarmSettings: alarmSettings);

                                  // final alarmSettings = AlarmSettings(
                                  //   id: 42,
                                  //   dateTime: datetimeMedicine,
                                  //   loopAudio: loopAudio,
                                  //   vibrate: vibrate,
                                  //   volumeMax: volumeMax,
                                  //   notificationTitle: showNotification
                                  //       ? 'แจ้งเตือนทานยา'
                                  //       : null,
                                  //   notificationBody: showNotification
                                  //       ? 'เวลาที่ทานยา ${AppUrl
                                  //       .objAddItemMedicine.timeNum[i]} วันนี้'
                                  //       : null,
                                  //   assetAudioPath: assetAudio,
                                  //   enableNotificationOnKill: true,
                                  //   stopOnNotificationOpen: true,
                                  // );
                                  // Alarm.set(alarmSettings: alarmSettings);
                                 if(i == AppUrl.objAddItemMedicine.timeNum.length-1){
                                   AppLoader.hide();
                                   AppLoader.showSuccess("บันทึกรายการสำเร็จ");
                                   Navigator.of(context)
                                       .pushNamedAndRemoveUntil(
                                       '/', (Route<dynamic> route) => false);
                                 }
                                }
                              }
                            }
                            // AppLoader.showSuccess("บันทึกรายการสำเร็จ");
                            // Navigator.of(context)
                            //     .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                          }

                      } else {
                        AppLoader.showError("กรุณาเพิ่มรูปและระบุฉลากยา");
                      }
                    },
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "ถัดไป",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily:
                                'SukhumvitSet-Bold'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _openPopupAddImage(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),

            title: Text(
              "กรุณาเพิ่มรูปยาและฉลากยา",
              style: TextStyle(
                fontFamily: 'SukhumvitSet-Bold',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.start,
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: mediaQuery(context, 'h', 20),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.only(
                                left: 5, right: 5, top: 10, bottom: 10),),
                          shape: MaterialStateProperty.resolveWith((states) =>
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),)),
                          backgroundColor: MaterialStateProperty.resolveWith((
                              states) => AppColors.colorMain),
                          elevation: MaterialStateProperty.resolveWith<double>(
                                (Set<MaterialState> states) {
                              return 2.0;
                            },),
                        ),
                        onPressed: () {
                          chooseImage(ImageSource.camera);
                        },
                        child: Text(
                          "ถ่ายรูป",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "SukhumvitSet-Bold"),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.only(
                                left: 5, right: 5, top: 10, bottom: 10),),
                          shape: MaterialStateProperty.resolveWith((states) =>
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),)),
                          backgroundColor: MaterialStateProperty.resolveWith((
                              states) => AppColors.colorMain),
                          elevation: MaterialStateProperty.resolveWith<double>(
                                (Set<MaterialState> states) {
                              return 2.0;
                            },),
                        ),
                        onPressed: () {
                          chooseImage(ImageSource.gallery);
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: Text(
                          "อัปโหลดรูป",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "SukhumvitSet-Bold"),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker().pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );
      setState(() {
        // img64 = "";
        Navigator.pop(context);
        fileImg = File(object!.path);
      });
      final bytes = File(object!.path).readAsBytesSync();
      img64 = base64Encode(bytes);
    } catch (e) {}
  }

  _openPopupInvalidate(context, title) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  mediaQuery(context, 'h', 50),
                ),
              ),
            ),

            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'SukhumvitSet-Bold',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: mediaQuery(context, 'h', 20),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ButtonTheme(
                        // minWidth: mediaQuery(context, 'h', 320),
                        // height: mediaQuery(context, 'h', 120),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(
                                  mediaQuery(context, 'h', 50),
                                ),
                                side: BorderSide(
                                  color: AppColors.color.withOpacity(0.51),
                                ),
                              ),
                            ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'ตกลง',
                            style: TextStyle(
                              fontFamily: 'SukhumvitSet-Bold',
                              color: AppColors.color,
                              fontSize: mediaQuery(context, 'h', 46),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
