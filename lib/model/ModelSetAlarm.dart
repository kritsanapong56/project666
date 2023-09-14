import 'package:flutter/widgets.dart';
import '../tool/api.dart';
import '../tool/loader.dart';
import '../../tool/url.dart';

class ModelSetAlarm {
  var alert_id ;
  var medicine_name;
  var date_medicine;
  var time_medicine;
  var type_period;
  var text_alarm;
  var type_sub_week;

  ModelSetAlarm (
      {required this.alert_id,
        required  this.medicine_name,
        required  this.date_medicine,
        required  this.time_medicine,
        required  this.type_period,
        required this.text_alarm,
        required this.type_sub_week});

  static getData() async {
    final response = await AppApi.apiGetRequest(AppUrl.get_data_alarm +
        "?register_id=" +
        AppUrl.RegisterID); // เรียกใช้ api
    data.clear(); // เคลียข้อมูลเดิมออกก่อน
    return response;
  }

  static saveData(context, Map<String, dynamic> data) async {
    final response =
    await AppApi.post_Json(AppUrl.insert_data_alarm, data); // เรียกใช้ api
    print(response);
    if (response['statusCode'] == 200) {
      // Navigator.pop(context);
    }
  }

  static updateData(context, Map<String, dynamic> data) async {
    final response = await AppApi.post_Json(
        AppUrl.update_profile_register, data); // เรียกใช้ api
    print(response);
    if (response['statusCode'] == 200) {
      // AppLoader.showSuccess("แก้ไขสำเร็จ");
      // EasyLoading.showSuccess("แก้ไขสำเร็จ");
      Navigator.pop(context);
    }
  }
  //

  static List<ModelSetAlarm> dataList = []; // ตัวแปรที่จะเรียกใช้งาน
  static List<ModelSetAlarm> data = []; // ตัวแปรที่จะเรียกใช้งาน

  ModelSetAlarm.fromJson(Map<String, dynamic> json) {
    alert_id  = json['alert_id'];
    medicine_name = json['medicine_name'];
    time_medicine = json['time_medicine'];
    type_period = json['type_period'];
    text_alarm = json['text_alarm'];
    type_sub_week= json['type_sub_week'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alert_id'] = this.alert_id;
    data['medicine_name'] = this.medicine_name;
    data['time_medicine'] = this.time_medicine;
    data['type_period'] = this.type_period;

    return data;
  }
}
