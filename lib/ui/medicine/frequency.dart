import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_safealert/tool/color.dart';
import 'package:flutter_alarm_safealert/ui/medicine/AddTimeAlertMedicine.dart';
import 'package:flutter_alarm_safealert/ui/medicine/TypeMedicine.dart';

class frequency extends StatefulWidget {
  const frequency({super.key});

  @override
  State<frequency> createState() => _frequencyState();
}

class _frequencyState extends State<frequency> {
  int selectedNumber = 1;
  String halo = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.colorMain,
          title: new Text("ความถี่การทานยา",style: TextStyle(
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
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'กำหนดวันที่ทานยา',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 20),
              DropdownButton<int>(
                value: selectedNumber,
                items: [
                  DropdownMenuItem(
                    child: Text("ประจำวัน",style: TextStyle(
            fontSize: 25,color: Colors.black,
              fontFamily: 'SukhumvitSet-Bold'),),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text("วันของสัปดาห์",style: TextStyle(
            fontSize: 25,color: Colors.black,
              fontFamily: 'SukhumvitSet-Bold'),),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text("ช่วงวัน",style: TextStyle(
            fontSize: 25,color: Colors.black,
              fontFamily: 'SukhumvitSet-Bold'),),
                    value: 3,
                  ),
                  DropdownMenuItem(
                    child: Text("รอบประจำเดือน",style: TextStyle(
            fontSize: 25,color: Colors.black,
              fontFamily: 'SukhumvitSet-Bold'),),
                    value: 4,
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedNumber = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTimeAlertMedicine(halo)),
                  );
                  // ทำอะไรก็ตามที่คุณต้องการเมื่อกดปุ่ม "หน้าถัดไป"
                  // ในตัวอย่างนี้เราจะแสดงข้อมูลที่ถูกเลือก
                  print('เลือกข้อมูล: $selectedNumber');
                },
                child: Text('หน้าถัดไป'),
              ),
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