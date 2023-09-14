import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomCupertinoDatePicker.dart';

class CustomCupertinoPickerApp extends StatefulWidget {
  const CustomCupertinoPickerApp({Key? key}) : super(key: key);
  @override
  State<CustomCupertinoPickerApp> createState() =>
      _CustomCupertinoPickerAppState();
}
class _CustomCupertinoPickerAppState extends
State<CustomCupertinoPickerApp> {
  late final DateTime _minDate;
  late final DateTime _maxDate;
  late DateTime _selecteDate;
  @override
  void initState() {
    super.initState();
    final currentDate = DateTime.now();
    _minDate = DateTime(
      currentDate.year - 100,
      currentDate.month,
      currentDate.day,
    );
    _maxDate = DateTime(
      currentDate.year - 18,
      currentDate.month,
      currentDate.day,
    );
    _selecteDate = _maxDate;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            height: 300,
            child: CustomCupertinoDatePicker(
              itemExtent: 50,
              minDate: _minDate,
              maxDate: _maxDate,
              selectedDate: _selecteDate,
              // selectionOverlay: Container(
              //   width: double.infinity,
              //   height: 50,
              //   decoration: const BoxDecoration(
              //     border: Border.symmetric(
              //       horizontal:BorderSide(color:Colors.grey,width:1),
              //     ),
              //   ),
              // ),
              selectedStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                fontFamily: 'SukhumvitSet-Bold',
              ),
              unselectedStyle: TextStyle(
                color: Colors.grey[800],
                fontSize: 18,
                fontFamily: 'SukhumvitSet-Bold',
              ),
              disabledStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 18,
              ),
              onSelectedItemChanged: (date) => _selecteDate = date,
            ),
          ),
        ),
      ),
    );
  }
}