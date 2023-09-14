import 'dart:convert';
import 'dart:io';
import 'dart:io';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../model/ModelMedicine.dart';
import '../../model/ModelDayMedicine.dart';
import '../../model/ModelMedicineAlarmNext.dart';
import '../../tool/color.dart'; 
import '../../tool/loader.dart';
import '../../tool/screen.dart';
import '../../tool/url.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as Io;
import 'package:bottom_sheet/bottom_sheet.dart';


import 'AddTimeAlertMedicine.dart';
class DetailMedicine extends StatefulWidget {
  ModelMedicineAlarmNext _medicine;
  DetailMedicine(this._medicine);
  @override
  _DetailMedicine createState() => _DetailMedicine();
}

class _DetailMedicine extends State<DetailMedicine> {

  TextEditingController txtMedicine = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
          backgroundColor: AppColors.colorMain,
          title: new Text("ข้อมูลยา",style: TextStyle(
            fontSize: 25,color: Colors.black,
              fontFamily: 'SukhumvitSet-Bold'),),
          leading: IconButton(
            icon: ImageIcon(
                AssetImage("assets/images/arrow_left.png"),
                  size:40,
                  color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
      ),
      body: Container(
        color: Colors.white, 
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 30.0,bottom: 30,left: 10,right: 10),
        child: Expanded( // ส่วนของลิสรายการ
          child: Column(
            children: [
              Text(widget._medicine.medicine_name,
                style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'SukhumvitSet-Medium',
                    color: Colors.black),),

              SizedBox(height: 20,),
              Text(widget._medicine.msg_alarm,
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'SukhumvitSet-Medium',
                    color: Colors.black),),
            ],
          )
        ),
      ),
    );
  }
  void _showSheet() {
    showFlexibleBottomSheet<void>(
      minHeight: 0,
      initHeight: 0.5,
      maxHeight: 1,
      context: context,
      builder: _buildBottomSheet,
      anchors: [0, 0.5, 1],
    );
  }

  List<Widget> _getChildren(
      double bottomSheetOffset, {
        required bool isShowPosition,
      }) =>
      [
        _buildTextField(),
      ];

  Widget _testContainer(Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        color: color,
      ),
    );
  }

  Widget _buildBottomSheet(
      BuildContext context,
      ScrollController scrollController,
      double bottomSheetOffset,
      ) {
    return SafeArea(
      child: Material(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: ListView(
              padding: const EdgeInsets.all(0),
              controller: scrollController,
              children: _getChildren(bottomSheetOffset, isShowPosition: true)),
        ),
      ),
    );
  }

  Widget _buildTextField() => const TextField(
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Enter a search term',
    ),
  );

  void _pushPageAddTimeAlert(BuildContext context, bool isHorizontalNavigation, String timeLineId) {
    Navigator.of(context, rootNavigator: !isHorizontalNavigation).push(
      _buildAdaptivePageRoute(
        builder: (context) => AddTimeAlertMedicine(timeLineId),
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
