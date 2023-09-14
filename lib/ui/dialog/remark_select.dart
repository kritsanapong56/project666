import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../tool/color.dart';  

class remark_select extends StatefulWidget {
  final List<String> items;
  const remark_select({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _remark_selectState();
}

class _remark_selectState extends State<remark_select> {
  // this variable holds the selected items
  String _selectedItems = "";

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems = itemValue;
        if(widget.items.last != itemValue){
          _submit();
        }
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
                _submit();
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
                      style:  TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'SukhumvitSet-Bold')
                  
                  )
                ], //<Widget>[]
              ),
            ],
          )
          )
              .toList(),
        ),
      ),
    );
  }
}