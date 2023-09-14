import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_safealert/screens/ring.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../tool/url.dart';
import '../ui/ListDataRegister.dart';
import '../ui/MainRouteHome.dart';
import '../widget/tile.dart';
import 'edit_alarm.dart';

class ExampleAlarmHomeScreen extends StatefulWidget {
  const ExampleAlarmHomeScreen({Key? key}) : super(key: key);

  @override
  State<ExampleAlarmHomeScreen> createState() => _ExampleAlarmHomeScreenState();
}

class _ExampleAlarmHomeScreenState extends State<ExampleAlarmHomeScreen> {
  late List<AlarmSettings> alarms;

  static StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    loadAlarms();
    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(alarmSettings),
    );
    // final alarmSettings = AlarmSettings(
    //   id: 42,
    //   dateTime: DateTime.now(),
    //   assetAudioPath: 'assets/marimba.mp3',
    //   volumeMax: false,
    //   enableNotificationOnKill: true,
    //   stopOnNotificationOpen: true,
    //   notificationTitle:'Alarm example',
    //   notificationBody: 'Your alarm (42) is ringing',
    // );
    // Alarm.set(alarmSettings: alarmSettings);
    // goToHome();
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ExampleAlarmRingScreen(alarmSettings: alarmSettings),
        ));
    loadAlarms();
  }

  Future<void> navigateToAlarmScreen(AlarmSettings? settings) async {
    final res = await showModalBottomSheet<bool?>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: ExampleAlarmEditScreen(alarmSettings: settings),
          );
        });

    if (res != null && res == true) loadAlarms();
  }

  @override
  void dispose() {
    // subscription?.cancel();
    super.dispose();
  }
  Future<void> goToHome() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Package alarm example app')),
      body: SafeArea(
        child: alarms.isNotEmpty
            ? ListView.separated(
                itemCount: alarms.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return ExampleAlarmTile(
                    key: Key(alarms[index].id.toString()),
                    title: TimeOfDay(
                      hour: alarms[index].dateTime.hour,
                      minute: alarms[index].dateTime.minute,
                    ).format(context),
                    onPressed: () => navigateToAlarmScreen(alarms[index]),
                    onDismissed: () {
                      Alarm.stop(alarms[index].id).then((_) => loadAlarms());
                    },
                  );
                },
              )
            : Center(
                child: Text(
                  "No alarms set",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () {
                // final alarmSettings = AlarmSettings(
                //   id: 42,
                //   dateTime: DateTime.now(),
                //   assetAudioPath: 'assets/marimba.mp3',
                //   volumeMax: false,
                // );
                // Alarm.set(alarmSettings: alarmSettings);
                goToHome();
              },
              backgroundColor: Colors.red,
              heroTag: null,
              child: const Text("RING NOW", textAlign: TextAlign.center),
            ),
            FloatingActionButton(
              onPressed: () => navigateToAlarmScreen(null),
              child: const Icon(Icons.alarm_add_rounded, size: 33),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
