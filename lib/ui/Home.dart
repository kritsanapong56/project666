import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import '../../tool/pref.dart';
import '../../tool/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ListDataRegister.dart';
import 'MainMenu.dart';
import 'MainRouteHome.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 10;

  int alarmId = 1;

  @override
  initState() {
    super.initState();
    new Timer(const Duration(seconds: 0), onClose);
  }
  Future<void> scheduleAlarm() async {
    await AndroidAlarmManager.oneShot(
      const Duration(microseconds: 0),
      alarmId,
      callback,
      rescheduleOnReboot: true,
      exact: true,
      wakeup: true,
    );
  }

  Future<void> scheduleCancelAlarm() async {
    await AndroidAlarmManager.oneShot(
      const Duration(microseconds: 0),
      alarmId,
      stopcallback,
      rescheduleOnReboot: true,
      exact: true,
      wakeup: true,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> callback() async {
    FlutterRingtonePlayer.playAlarm(
      looping: true,
      asAlarm: false,
      volume: 1.0,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> stopcallback() async {
    AndroidAlarmManager.cancel(1);
    FlutterRingtonePlayer.stop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(211,234,250, 1),
      body: Align(
          alignment: Alignment(0.0, 0.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 190,
                  width: 190,
                ),
                Center(
                  child: Text(
                    "เเอปพลิเคชั่น\nแจ้งตือนกินยา",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontFamily: 'SukhumvitSet-Bold'),
                      textAlign: TextAlign.center
                  ),
                ),
              ],
            ),
          )),

    );
  }
  Future<void> onClose() async {
    // Navigator.push(this.context, CupertinoPageRoute(builder: (context) {
    //   return ButtonRegister();
    // }));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      String? register_id = prefs.getString('register_id');
      AppUrl.RegisterID = register_id!;
    } catch (e) {
      print(e);
    }

    if (AppUrl.RegisterID != ""){
      Navigator.of(this.context).pushReplacement(new PageRouteBuilder(
          maintainState: true,
          opaque: true,
          pageBuilder: (context, _, __) => new MainRouteHome(),
          transitionDuration: const Duration(seconds: 0),
          transitionsBuilder: (context, anim1, anim2, child) {
            return new FadeTransition(
              child: child,
              opacity: anim1,
            );
          }));
    }else {
      Navigator.of(this.context).pushReplacement(new PageRouteBuilder(
          maintainState: true,
          opaque: true,
          pageBuilder: (context, _, __) => new ListDataRegister(),
          transitionDuration: const Duration(seconds: 0),
          transitionsBuilder: (context, anim1, anim2, child) {
            return new FadeTransition(
              child: child,
              opacity: anim1,
            );
          }));
    }
  }
}

