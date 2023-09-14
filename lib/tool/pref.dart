import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'url.dart';

setPref(type, name, value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  type == 'int'
      ? await prefs.setInt(name, value)
      : type == 'string' || type == 'String'
          ? await prefs.setString(name, value)
          : await prefs.setBool(name, value);
}

getPref(type, name) async {
  var value;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  type == 'int'
      ? value = await prefs.getInt(name)
      : type == 'string' || type == 'String'
          ? value = await prefs.getString(name)
          : value = await prefs.getBool(name);

  return value;
}
