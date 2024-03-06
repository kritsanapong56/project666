import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_safealert/tool/color.dart';
import 'package:flutter_alarm_safealert/ui/medicine/AddTimeAlertMedicine.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:weekday_selector/weekday_selector.dart';

StreamController<List<String>> selectedDaysController =
    StreamController<List<String>>.broadcast();

class frequency extends StatefulWidget {
  const frequency({super.key});

  @override
  State<frequency> createState() => _frequencyState();
}

class DateSelector extends StatefulWidget {
  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  int _selectedValue = 1;
  String _selectedType = 'Day';

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> _dropdownMenuItems = [
      const DropdownMenuItem(
          value: 'Day',
          child: Text(
            'วัน',
            style: TextStyle(fontSize: 25),
          )),
      const DropdownMenuItem(
          value: 'Week',
          child: Text(
            'สัปดาห์',
            style: TextStyle(fontSize: 25),
          )),
      const DropdownMenuItem(
          value: 'Month',
          child: Text(
            'เดือน',
            style: TextStyle(fontSize: 25),
          )),
    ];
    List<DropdownMenuItem<int>> _daysDropdownMenuItems =
        List.generate(365, (index) {
      return DropdownMenuItem(
          value: index + 1,
          child: Text(
            '${index + 1}',
            style: const TextStyle(fontSize: 25),
          ));
    });
    List<DropdownMenuItem<int>> _monthsDropdownMenuItems =
        List.generate(12, (index) {
      return DropdownMenuItem(
          value: index + 1,
          child: Text(
            '${index + 1}',
            style: const TextStyle(fontSize: 25),
          ));
    });
    List<DropdownMenuItem<int>> _weeksDropdownMenuItems =
        List.generate(52, (index) {
      return DropdownMenuItem(
          value: index + 1,
          child: Text(
            '${index + 1}',
            style: const TextStyle(fontSize: 25),
          ));
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        const Text(
          'เลือกช่วงวัน',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton(
              value: _selectedValue,
              items: _selectedType == 'Day'
                  ? _daysDropdownMenuItems
                  : (_selectedType == 'Month'
                      ? _monthsDropdownMenuItems
                      : _weeksDropdownMenuItems),
              onChanged: (value) {
                setState(() {
                  _selectedValue = value!;
                });
              },
            ),
            DropdownButton(
              value: _selectedType,
              items: _dropdownMenuItems,
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                  _selectedValue = 1; // Reset selected value when changing type
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.only(bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "วันที่เลือก: ${getSelectedDate()}",
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // No data needs to be passed
                },
                child: const Text(
                  'ตกลง',
                  style: TextStyle(fontSize: 23),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String getSelectedDate() {
    switch (_selectedType) {
      case 'Day':
        return "$_selectedValue วัน";
      case 'Month':
        return "$_selectedValue เดือน";
      case 'Week':
        return "$_selectedValue สัปดาห์";
      default:
        return "";
    }
  }
}

class _frequencyState extends State<frequency> {
  var _stxtHBD = "";
  TextEditingController txtHBD = TextEditingController();
  TextEditingController selectfrequency = TextEditingController();
  int selectedNumber = 1;
  String halo = "0";
  String dropdownValue = '';
  final values = List.filled(7, true);
  int _selectedValue = 1;
  String _selectedType = 'Day';
  final List<DropdownMenuItem<String>> _dropdownMenuItems = [
    const DropdownMenuItem(
        value: 'Day',
        child: Text(
          'วัน',
          style: TextStyle(fontSize: 25),
        )),
    const DropdownMenuItem(
        value: 'Week',
        child: Text(
          'สัปดาห์',
          style: TextStyle(fontSize: 25),
        )),
    const DropdownMenuItem(
        value: 'Month',
        child: Text(
          'เดือน',
          style: TextStyle(fontSize: 25),
        )),
  ];
  final List<DropdownMenuItem<int>> _daysDropdownMenuItems =
      List.generate(365, (index) {
    return DropdownMenuItem(
        value: index + 1,
        child: Text(
          '${index + 1}',
          style: const TextStyle(fontSize: 25),
        ));
  });
  final List<DropdownMenuItem<int>> _monthsDropdownMenuItems =
      List.generate(12, (index) {
    return DropdownMenuItem(
        value: index + 1,
        child: Text(
          '${index + 1}',
          style: const TextStyle(fontSize: 25),
        ));
  });
  final List<DropdownMenuItem<int>> _weeksDropdownMenuItems =
      List.generate(52, (index) {
    return DropdownMenuItem(
        value: index + 1,
        child: Text(
          '${index + 1}',
          style: const TextStyle(fontSize: 25),
        ));
  });

  String getSelectedDate() {
    switch (_selectedType) {
      case 'Day':
        return "$_selectedValue วัน";
      case 'Month':
        return "$_selectedValue เดือน";
      case 'Week':
        return "$_selectedValue สัปดาห์";
      default:
        return "";
    }
  }

  // String getSelectedDaysString(List<bool> values) {
  //   List<String> selectedDays = [];
  //   for (int i = 0; i < values.length; i++) {
  //     if (values[i]) {
  //       selectedDays.add(getDayNameFromIndex(i));
  //     }
  //   }
  //   return selectedDays.isEmpty ? "" : selectedDays.join(', ');
  // }
  String getSelectedDaysString(List<bool> values) {
    List<String> selectedDays = [];
    for (int i = 0; i < values.length; i++) {
      if (values[i]) {
        selectedDays.add(getDayNameFromIndex(i));
      }
    }
    return selectedDays.isEmpty ? 'ไม่เลือกวัน' : selectedDays.join(', ');
  }

  String getDayNameFromIndex(int index) {
    // Convert index to day name, customize as needed
    switch (index) {
      case 0:
        return 'อา';
      case 1:
        return 'จ';
      case 2:
        return 'อ';
      case 3:
        return 'พ';
      case 4:
        return 'พฤ';
      case 5:
        return 'ศ';
      case 6:
        return 'ส';
      // ... Continue for other days
      default:
        return '';
    }
  }

  void printSelectedDays() {
    List<String> selectedDayNames = [];
    for (int i = 0; i < selectedDays.length; i++) {
      if (selectedDays[i]) {
        String dayName = getDayNameFromIndex(i);
        selectedDayNames.add(dayName);
      }
    }
    print('Selected Days: $selectedDayNames');
  }

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

  List<bool> selectedDays = List.filled(7, false);
  void handleBottomSheetItemTap(String value) {
    if (value == 'วันของสัปดาห์') {
      showModalBottomSheet<void>(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (
          BuildContext context,
        ) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0, top: 15),
                child: Text(
                  'เลือกวันของสัปดาห์',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 92,
                child: WeekdaySelector(
                  onChanged: (int day) {
                    setState(() {
                      final index = day % 7;
                      values[index] = !values[index];
                      selectedDays[index] =
                          !selectedDays[index]; // Store selected values
                      printSelectedDays(); // Call the function to print selected days
                    });
                  },
                  values: values,
                  shortWeekdays: const ['อา', 'จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส'],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      {
                        dropdownValue = 'วันของสัปดาห์';
                        print(selectedDays);
                        Navigator.of(context).pop(); // Close the bottom sheet
                      }
                    },
                    child: const Text('ตกลง',
                        style: TextStyle(
                          fontFamily: 'SukhumvitSet-medium',
                          fontSize: 24,
                        )),
                  )),
            ],
          );
        },
      );
    } else if (value == 'ช่วงวัน') {
      SizedBox(
        child: DateSelector(),
      );
      showModalBottomSheet<void>(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          context: context,
          builder: (BuildContext context) {
            return SingleChildScrollView(child: DateSelector());
          });
    } else {
      // Handle other options ('ประจำวัน', 'ช่วงวัน')
    }
  }

  bool showWeekdaySelector = false;
  bool isChecked = false;
  bool showSecondColumn = false;
  int selectedRadio = 0;
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
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: selectedRadio,
                    onChanged: (int? value) {
                      setState(() {
                        selectedRadio = value ?? 0;
                      });
                    },
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ประจำวัน",
                        style: TextStyle(
                          fontSize: 21.0,
                          fontFamily: 'SukhumvitSet-Medium',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //////////////////////แสดงประจำวัน
            if (selectedRadio == 1)
              Container(
                margin: const EdgeInsets.only(top: 10, left: 20),
                width: double.maxFinite,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.resolveWith(
                              (states) => RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            print("ประจำวัน");
                          },
                          child: const Text(
                            "ประจำวัน",
                            style: TextStyle(
                              fontSize: 23,
                              fontFamily: 'SukhumvitSet-Medium',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: selectedRadio,
                    onChanged: (int? value) {
                      setState(() {
                        selectedRadio = value ?? 0;
                      });
                    },
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "วันของสัปดาห์",
                        style: TextStyle(
                          fontSize: 21.0,
                          fontFamily: 'SukhumvitSet-Medium',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
//////////// /////////กดเลือกradio แสดง วัน//////////////////////////////////
            if (selectedRadio == 2)
              SizedBox(
                height: 92,
                child: WeekdaySelector(
                  onChanged: (int day) {
                    setState(() {
                      final index = day % 7;
                      values[index] = !values[index];
                      selectedDays[index] =
                          !selectedDays[index]; // Store selected values
                      printSelectedDays(); // Call the function to print selected days
                    });
                  },
                  values: values,
                  shortWeekdays: const ['อา', 'จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส'],
                ),
              ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Radio(
                    value: 3,
                    groupValue: selectedRadio,
                    onChanged: (int? value) {
                      setState(() {
                        selectedRadio = value ?? 0;
                      });
                    },
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ช่วงวัน",
                        style: TextStyle(
                          fontSize: 21.0,
                          fontFamily: 'SukhumvitSet-Medium',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (selectedRadio == 3)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  const Text(
                    'เลือกช่วงวัน',
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButton(
                        value: _selectedValue,
                        items: _selectedType == 'Day'
                            ? _daysDropdownMenuItems
                            : (_selectedType == 'Month'
                                ? _monthsDropdownMenuItems
                                : _weeksDropdownMenuItems),
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                      ),
                      DropdownButton(
                        value: _selectedType,
                        items: _dropdownMenuItems,
                        onChanged: (value) {
                          setState(() {
                            _selectedType = value!;
                            _selectedValue =
                                1; // Reset selected value when changing type
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "วันที่เลือก: ${getSelectedDate()}",
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                                context); // No data needs to be passed
                          },
                          child: const Text(
                            'ตกลง',
                            style: TextStyle(fontSize: 23),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            Container(
              width: 380,
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisSize:
                            MainAxisSize.min, // Prevent wrapping content
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
                            onTap: () =>
                                handleBottomSheetItemTap('วันของสัปดาห์'),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bgColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  getSelectedDaysString(selectedDays),
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'SukhumvitSet-Medium',
                    color: Colors.grey[800],
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
                margin: const EdgeInsets.only(right: 5),
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
