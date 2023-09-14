import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:io';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_safealert/model/ModeReportEat.dart';
import 'package:flutter_alarm_safealert/model/ModeReportSkip.dart';
import 'package:flutter_alarm_safealert/model/ModelDetailMedicine.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../model/ModeReport.dart';
import '../../model/ModelAlarmMedicine.dart';
import '../../model/ModelMedicine.dart';
import '../../model/ModelMedicineAlarmNext.dart';
import '../../model/ModelRegister.dart';
import '../../tool/color.dart';
import '../../tool/loader.dart';
import '../../tool/screen.dart';
import '../../tool/url.dart';
import '../../ui/medicine/DetailMedicine.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as Io;
import 'package:bottom_sheet/bottom_sheet.dart';

import '../MainMenu.dart';
import '../medicine/AddMedicine.dart';
class ReportEatMedicine extends StatefulWidget {
  ReportEatMedicine();
  @override
  _ReportEatMedicine createState() => _ReportEatMedicine();
}

class _ReportEatMedicine extends State<ReportEatMedicine> {

  int _counter = 0;
  var fDate = new DateFormat('yyyy-MM-dd');

  TextEditingController txtMedicine = TextEditingController();
  Map<String, List<ModelReport>> resultAlarmMedicine = {};
  Map<String, List<ModelReportSkip>> reportSkip = {};
  Map<String, List<ModelReportEat>> reportEat = {};
  List<ModelReport> listDetailMedicine = [];
  List<ModelReport> listAlarmMedicine = [];
  List<ModelMedicine> ReportEatMedicine = [
    ModelMedicine(id: 1, name: 'ยาลดไข้',dateTime: DateTime.now(),messageDateTime: "แจ้งเตือนครั้งต่อไป วันพรุ่งนี้เวลา 19.00 น."),
  ];
  var strEmpty = "";
  @override
  void initState() {
    loadDataMedicineAlarmNext();
    super.initState();
  }
  void loadDataMedicineAlarmNext() async {
    AppLoader.show();
    listDetailMedicine.clear();
    final list = await ModelReport.getReport();
      listDetailMedicine = List<ModelReport>.from(list?.map((i) => ModelReport.fromMap(i)));
      resultAlarmMedicine = listDetailMedicine.groupListsBy((student) => student.date_report);

    Map<String, List<ModelReportSkip>> reportSkips = {};
    Map<String, List<ModelReportEat>> reportEats = {};
      resultAlarmMedicine.forEach((key, reports) async {
        var alarmTime = DateTime.parse(key);
        var strTime = DateFormat('dd/MM/yyyy').format(alarmTime);
        final listSkip = await ModelReport.getReportSkip(key);
        var mReportSkip = List<ModelReportSkip>.from(listSkip?.map((i) => ModelReportSkip.fromMap(i)));

        final listEat = await ModelReport.getReportEat(key);
        var mReportEat = List<ModelReportEat>.from(listEat?.map((i) => ModelReportEat.fromMap(i)));
        reportSkips[strTime] = mReportSkip;
        reportEats[strTime] = mReportEat;

        setState(() {
          reportSkip = reportSkips;
          reportEat = reportEats;
        });

      });
      if(resultAlarmMedicine.isEmpty){
        strEmpty = 'ไม่มีรายงาน';
      }

      AppLoader.hide();
  }
  //
  Widget _buildListSkip(List<ModelReportSkip> listAlarm) {
    List<Widget> chips = [];

    for (int i = 0; i < listAlarm.length; i++) {
      Container choiceChip = Container(
        child: Row(
          children: [
            Text('${listAlarm[i].medicine_name} , ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: 'SukhumvitSet-Bold'
              ),
            ),
            SizedBox(width: 10,),

            Text('เวลา ${listAlarm[i].skip_time}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: 'SukhumvitSet-Bold'
              ),
            ),
          ],
        ),
      );
      chips.add(choiceChip);
    }
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: chips,
    );
  }
  Widget _buildListEat(List<ModelReportEat> listAlarm) {
    List<Widget> chips = [];

    for (int i = 0; i < listAlarm.length; i++) {
      Container choiceChip = Container(
                child: Row(
                  children: [
                  Text('${listAlarm[i].medicine_name} , ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: 'SukhumvitSet-Bold'
                    ),
                  ),
                    SizedBox(width: 10,),

                    Text('เวลา ${listAlarm[i].eat_time}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'SukhumvitSet-Bold'
                      ),
                    ),
                  ],
                ),
              );
      chips.add(choiceChip);
    }
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: chips,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.bdColor,
      appBar:AppBar(
        centerTitle: true,
        title: Text('รายงานการทานยา',
            style: TextStyle(fontFamily: 'SukhumvitSet-Bold',
                fontSize: 22,fontWeight: FontWeight.w500
            )
        ),
        leadingWidth: 0,
        leading: Container(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black,
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.only(top: 20,bottom: 20),
        child:
        Expanded(
            child:
            ListView.builder(
                itemCount:resultAlarmMedicine.length,
              itemBuilder: (BuildContext context, int index) {
                var strReportTime = resultAlarmMedicine.keys.toList()[index];
                var alarmTime = DateTime.parse(strReportTime);
                var strTime = DateFormat('dd/MM/yyyy').format(alarmTime);
                var reportSkipLength = 0;
                List<ModelReportSkip> objReportSkip = [];
                reportSkip.forEach((key, value) {
                  if(key == strTime){
                    reportSkipLength = value.length;
                    objReportSkip = value;
                  }
                });

                var reportEatLength = 0;
                List<ModelReportEat> objReportEat = [];
                reportEat.forEach((key, value) {
                  if(key == strTime){
                    reportEatLength = value.length;
                    objReportEat = value;
                  }
                });
                return

                  Container(
                    alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    strTime,
                                    style: TextStyle(fontSize: 24,
                                        fontFamily: 'SukhumvitSet-Bold', fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 50,right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("ข้าม ($reportSkipLength)",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'SukhumvitSet-Bold'),
                                    textAlign: TextAlign.start),

                                  Container(
                                  padding: EdgeInsets.only(left: 20,right: 20),
                                  child: _buildListSkip(objReportSkip),
                                  ),

                                Text("ทาน ($reportEatLength)",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'SukhumvitSet-Bold'),
                                    textAlign: TextAlign.start),

                                Container(
                                  padding: EdgeInsets.only(left: 20,right: 20),
                                  child: _buildListEat(objReportEat),
                                ),
                              ],
                            ),
                          )

                        ],
                      )
                  ) ;
              },
            )
        ),
      ),
    );
  }

  void _pushPageDetailMedicine(BuildContext context, bool isHorizontalNavigation,ModelMedicineAlarmNext medicine) {
    Navigator.of(context, rootNavigator: !isHorizontalNavigation).push(
      _buildAdaptivePageRoute(
        builder: (context) => DetailMedicine(medicine),
        fullscreenDialog: !isHorizontalNavigation,
      ),
    ).then((value) {
      const Duration(seconds: 2);
      // ReloadData();
    });
  }

// Flutter will use the fullscreenDialog property to change the animation
// and the app bar's left icon to an X instead of an arrow.
  PageRoute<T> _buildAdaptivePageRoute<T>({
    required WidgetBuilder builder,
    bool fullscreenDialog = false,
  }) =>
      Platform.isAndroid
          ? MaterialPageRoute(
        builder: builder,
        fullscreenDialog: fullscreenDialog,
      )
          : CupertinoPageRoute(
        builder: builder,
        fullscreenDialog: fullscreenDialog,
      );
}
