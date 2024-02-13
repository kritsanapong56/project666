import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_safealert/tool/color.dart';
import 'package:flutter_alarm_safealert/ui/medicine/AddTimeAlertMedicine.dart';
import 'package:flutter_alarm_safealert/ui/medicine/TypeMedicine.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';

class frequency extends StatefulWidget {
  const frequency({super.key});

  @override
  State<frequency> createState() => _frequencyState();
}

class _frequencyState extends State<frequency> {
  var _stxtHBD = "";
  TextEditingController txtHBD = TextEditingController();
  int selectedNumber = 1;
  String halo = "0";
  String dropdownValue = 'ประจำวัน';
  void dateHBD(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    Timer(const Duration(milliseconds: 400), () {
      int yearCurrent = DateTime.now().year + 1;
      showRoundedDatePicker(
        borderRadius: 25,
        styleDatePicker: MaterialRoundedDatePickerStyle(
          textStyleDayHeader: const TextStyle(
              fontFamily: 'SukhumvitSet-Bold',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.color_grey),
          textStyleDayOnCalendar: const TextStyle(
              fontFamily: 'SukhumvitSet-Bold',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.color_grey),
          paddingMonthHeader: EdgeInsets.all(10),
          sizeArrow: 40,
          colorArrowPrevious: AppColors.colorMain,
          colorArrowNext: AppColors.colorMain,
          textStyleMonthYearHeader: const TextStyle(
              fontFamily: 'SukhumvitSet-Bold',
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black),
          textStyleButtonPositive: const TextStyle(
              fontFamily: 'SukhumvitSet-Bold',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.color_grey),
          textStyleButtonNegative: const TextStyle(
              fontFamily: 'SukhumvitSet-Bold',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.color_grey),
        ),
        theme: ThemeData(
          primaryColor: AppColors.colorMain,
          hintColor: AppColors.colorMain,
          textTheme: const TextTheme(
            caption: TextStyle(
                fontFamily: 'SukhumvitSet-Bold',
                fontWeight: FontWeight.w500,
                color: AppColors.color_grey),
          ),
        ),
        // era: EraMode.BUDDHIST_YEAR,
        context: context,
        height: 330,
        fontFamily: 'SukhumvitSet-Bold',
        // locale: const Locale("th"),
        initialDate: DateTime.now(),
        firstDate: DateTime(1850),
        lastDate: DateTime(yearCurrent),
      ).then((date) {
        setState(() {
          _stxtHBD = DateFormat('yyyy-MM-dd').format(date!);
          var strDay = DateFormat('dd/MM/yyyy').format(date!);
          txtHBD.text = strDay;

          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        });
      });
    });
  }
  void handleBottomSheetItemTap(String value) {
  setState(() {
    dropdownValue = value;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.colorMain,
        title: const Text(
          "ความถี่การทานยา",
          style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontFamily: 'SukhumvitSet-Bold'),
        ),
        leading: IconButton(
          icon: const ImageIcon(
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
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 10,
                left: 20,
              ),
              width: double.maxFinite,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ความถี่ในการทานยา",
                    style: TextStyle(
                      fontSize: 23.0,
                      fontFamily: 'SukhumvitSet-Medium',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
    width: 380,
    child: ElevatedButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min, // Prevent wrapping content
              children: <Widget>[
                ListTile(
                  title: Text(
                    'ประจำวัน',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'SukhumvitSet-Medium',
                      color: Colors.grey[800],
                    ),
                  ),
                  onTap: () => handleBottomSheetItemTap('ประจำวัน'),
                ),
                ListTile(
                  title: Text(
                    'วันของสัปดาห์',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'SukhumvitSet-Medium',
                      color: Colors.grey[800],
                    ),
                  ),
                  onTap: () => handleBottomSheetItemTap('วันของสัปดาห์'),
                ),
                ListTile(
                  title: Text(
                    'ช่วงวัน',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'SukhumvitSet-Medium',
                      color: Colors.grey[800],
                    ),
                  ),
                  onTap: () => handleBottomSheetItemTap('ช่วงวัน'),
                ),
              ],
            );
          },
        );
      },
      child: Text(
        dropdownValue ?? "เลือก", // Display "เลือก" if no value is selected
        style: TextStyle(
          fontSize: 22,
          fontFamily: 'SukhumvitSet-Medium',
          color: Colors.grey[800],
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align text to the start
                          children: [
                            const Text(
                              "เริ่มต้น",
                              style: TextStyle(
                                fontSize: 23.0,
                                fontFamily: 'SukhumvitSet-Medium',
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                                height:
                                    10), // Adjust the spacing between "เริ่มต้น" and TextField
                            TextField(
                              onTap: () {
                                dateHBD(context);
                              },
                              controller: txtHBD,
                              readOnly: true,
                              style: const TextStyle(
                                fontSize: 25.0,
                                fontFamily: 'SukhumvitSet-Bold',
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 15,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                                filled: true,
                                hintText: "วันที่เริ่มทาน",
                                hintStyle: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'SukhumvitSet-Medium',
                                  color: Colors.grey[800],
                                ),
                                fillColor: AppColors.bgColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => AddTimeAlertMedicine(halo)),
            //     );
            //     print('เลือกข้อมูล: $selectedNumber');
            //   },
            //   child: Text('หน้าถัดไป'),
            // ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
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
                      EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                    ),
                    shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => AppColors.colorMain),
                    elevation: MaterialStateProperty.resolveWith<double>(
                      (Set<MaterialState> states) {
                        return 2.0;
                      },
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(context,
                    //     CupertinoPageRoute(builder: (context) {
                    //       return MainMenu();
                    //     }));
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text(
                          "ย้อนกลับ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'SukhumvitSet-Bold'),
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
                margin: const EdgeInsets.only(left: 5),
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.only(
                          left: 5, right: 5, top: 10, bottom: 10),
                    ),
                    shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => AppColors.colorMain),
                    elevation: MaterialStateProperty.resolveWith<double>(
                      (Set<MaterialState> states) {
                        return 2.0;
                      },
                    ),
                  ),
                  // onPressed: () {
                  //   if(txtMedicine.text.isNotEmpty && _selectedIndex > -1) {
                  //     AppUrl.objAddItemMedicine.nameMedicine = txtMedicine.text.toString();
                  //     AppUrl.objAddItemMedicine.timeTakeId = _selectedTimeTakeId;
                  //     _pushPagetest(context,false);
                  //    }else {
                  //     _openPopupInvalidate(context,"กรุณากรอกข้อมูลให้ครบถ้วน");
                  //   }
                  // },

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddTimeAlertMedicine(halo)),
                    );
                    print('เลือกข้อมูล: $selectedNumber');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text(
                          "ถัดไป",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'SukhumvitSet-Bold'),
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
    );
  }

  Widget buildNumberButton(int number) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedNumber = number;
        });
      },
      child: Text('$number'),
    );
  }
}



// กดหดหกดหกฝ

