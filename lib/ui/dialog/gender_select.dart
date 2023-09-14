import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../tool/color.dart';

class gender_select extends StatefulWidget {
  final List<String> items;
  final String defaults;
  const gender_select({Key? key, required this.items, required this.defaults}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _gender_selectState();
}

class _gender_selectState extends State<gender_select> {
  // this variable holds the selected items
  String _selectedItems = "";

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
    _selectedItems = widget.defaults;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('โปรดเลือกคำนำหน้าชื่อ',
          style: TextStyle(fontFamily: 'SukhumvitSet-Bold',
            fontSize: 20,fontWeight: FontWeight.w500
          )
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[ //SizedBox
                  Checkbox(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    checkColor: Colors.black,
                    activeColor: AppColors.colorMain,
                    value: _selectedItems == item,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ), //Checkbox
                  Text(item.toString(),
                      style: TextStyle(fontFamily: 'SukhumvitSet-Bold',
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.left),
                ], //<Widget>[]
              ),
            ],
          )
          )
              .toList(),
        ),
      ),
      actions: [
        Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top:5,bottom: 10,left: 10,right: 10),
          decoration: BoxDecoration(
              color: AppColors.colorMain,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.16) ,
                    offset: Offset(5, 5),
                    blurRadius: 10)
              ]),
          child: InkWell(
            onTap: _submit,
            child:  Row(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ยืนยัน",
                          style: TextStyle(fontFamily: 'SukhumvitSet-Bold',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color:Colors.black),
                          textAlign: TextAlign.left,),
                      ]),
                ]
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top:5,bottom: 10,left: 10,right: 10),
          decoration: BoxDecoration(
              color: AppColors.color_grey,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.16) ,
                    offset: Offset(5, 5),
                    blurRadius: 10)
              ]),
          child: InkWell(
            onTap: _cancel,
            child:  Row(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ยกเลิก",
                          style: TextStyle(fontFamily: 'SukhumvitSet-Bold',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color:Colors.black),
                          textAlign: TextAlign.left,),
                      ]),
                ]
            ),
          ),
        ),
      ],
    );
  }
}