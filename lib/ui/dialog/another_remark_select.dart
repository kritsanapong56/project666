import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../tool/color.dart';

class another_remark_select extends StatefulWidget {

  const another_remark_select({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _another_remark_selectState();
}

class _another_remark_selectState extends State<another_remark_select> {
  // this variable holds the selected items
  String _selectedItems = "";
  TextEditingController txtRemarkAnother = TextEditingController();

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems = itemValue;
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(right: 5),
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.black,
                size: 40,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text('เหตุผลการข้ามทานยา',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: 'SukhumvitSet-Bold'
              ),
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(top: 20,left: 10,right: 10),
                          width: double.maxFinite,
                          child: TextField(
                            controller: txtRemarkAnother,
                            enabled: true,
                            maxLines: 5,
                            style: TextStyle(
                                fontSize: 25.0,
                                fontFamily: 'SukhumvitSet-Bold',
                                color: Colors.black),
                            decoration: new InputDecoration(
                                hintMaxLines: 3,
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
                                hintText: "กรุณากรอกเหตุผลการข้ามทานยา",
                                hintStyle: new TextStyle(
                                    fontFamily: 'SukhumvitSet-Medium',
                                    color: Colors.grey[800]),
                                fillColor:AppColors.bgColor),
                            // fillColor: Colors.white70),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.only(top: 30,bottom: 30),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),),
                              shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0), )),
                              backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.colorMain),
                              elevation: MaterialStateProperty.resolveWith<double>(
                                    (Set<MaterialState> states) {
                                  return 2.0;
                                },),
                            ),
                            onPressed: () {
                              if(txtRemarkAnother.text != "") {

                              }else{
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                              width: 120,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "ตกลง",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily:
                                    'SukhumvitSet-Bold'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
