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

import '../../model/ModelPeriodMedicine.dart';
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

import 'SelectStartMedicine.dart';
import 'TimeDayMedicine.dart';
class PeriodMedicine extends StatefulWidget {
  PeriodMedicine();
  @override
  _PeriodMedicine createState() => _PeriodMedicine();
}

class _PeriodMedicine extends State<PeriodMedicine> {
  var strEmpty = '';
  TextEditingController txtMedicine = TextEditingController();

  List<ModelPeriodMedicine> listPeriod = [
    // ModelPeriodMedicine(timeLineId: "1", name: 'ทุกวัน'),
    // ModelPeriodMedicine(timeLineId: "2", name: 'กำหนดวันเอง'),
  ];
  @override
  void initState() {
    loadDataPeriod();
    super.initState();
  }

  void loadDataPeriod() async {
    listPeriod.clear();
    final list = await ModelPeriodMedicine.getPeriod();
    setState(() {
      listPeriod = List<ModelPeriodMedicine>.from(list?.map((i) => ModelPeriodMedicine.fromMap(i)));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
          backgroundColor: AppColors.colorMain,
          title: new Text("ระยะเวลาในการทานยา",style: TextStyle(
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
        width: double.maxFinite,
        height: double.maxFinite,
        margin: EdgeInsets.only(top: 30.0,left: 20,right: 20),
        child: Expanded( // ส่วนของลิสรายการ
          child: listPeriod.length > 0 // กำหนดเงื่อนไขตรงนี้
              ? ListView.separated( // กรณีมีรายการ แสดงปกติ
            itemCount: listPeriod.length,
            itemBuilder: (context, index) {
              ModelPeriodMedicine objType = listPeriod[index];

              Widget card; // สร้างเป็นตัวแปร
              card = Card(
                margin: EdgeInsets.only(left:10,right: 10,bottom: 20),
                color: AppColors.bgColor, // สี
                // shadowColor: Colors.red.withAlpha(100), // สีของเงา
                // elevation: 5.0, // การยกของเงา
                shape: RoundedRectangleBorder( // รูปแบบ
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: (){
                    AppUrl.objAddItemMedicine.periodId = objType.periodId;
                    _pushPageSelectStartMedicine(context,false);
                  },
                  child: ListTile(
                    title: Text(objType.periodName,
                      style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'SukhumvitSet-Medium',
                          color: Colors.black),),
                  ),
                )
              );
              return card;
            },
            separatorBuilder: (BuildContext context, int index) => const SizedBox(),
          )
              :   Center(child: Text(strEmpty,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'SukhumvitSet-Bold'),
              textAlign: TextAlign.center),)// กรณีไม่มีรายการ
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

void _pushPageSelectStartMedicine(BuildContext context, bool isHorizontalNavigation) {
  Navigator.of(context, rootNavigator: !isHorizontalNavigation).push(
    _buildAdaptivePageRoute(
      builder: (context) => SelectStartMedicine(),
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
