import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import '../../ui/Home.dart';
import '../../ui/MainMenu.dart';


class MainRouteHome extends StatefulWidget {
  @override
  _MainRouteHomeState createState() => _MainRouteHomeState();
}

class _MainRouteHomeState extends State<MainRouteHome> {

  @override
  initState() {
    FlutterRingtonePlayer.stop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink,
        hintColor: Colors.purple,
        textTheme: TextTheme(bodyText1: TextStyle(color: Colors.red)),
      ),
      title: 'First Flutter App',
      initialRoute: '/', // สามารถใช้ home แทนได้
      routes: {
        MainMenu.routeName: (context) => MainMenu(),
      },
    );
  }
}
