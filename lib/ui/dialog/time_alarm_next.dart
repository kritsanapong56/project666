import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../tool/color.dart';  

class time_alarm_next extends StatefulWidget {

  const time_alarm_next({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _time_alarm_nextState();
}

class _time_alarm_nextState extends State<time_alarm_next> {
  // this variable holds the selected items
  var min = [5,10,15,20,25,30,35,40,60,90,120];
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
            child: Text('เลื่อนการแจ้งเตือน',
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
      content: Builder(
        builder: (context) {
      // Get available height and width of the build area of this widget. Make a choice depending on the size.
      var height = MediaQuery.of(context).size.height;
      var width = MediaQuery.of(context).size.width;

      return Container(
        height: height/4,
        width: width-50,
        child: new  GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // แสดง 3 คอลัมน์
              childAspectRatio: 1.0,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
            itemCount: min.length,
            itemBuilder: (BuildContext context, int index) {
              var mins = min[index];
              return InkWell(
                onTap: (){
                  _selectedItems = mins.toString();
                  _submit();
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$mins \nนาที",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily:
                            'SukhumvitSet-Bold'),
                      ),
                    ],
                  ),
                )
              );
            }),
      );
    }) 
    );
  }
}
