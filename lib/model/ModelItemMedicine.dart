import 'package:flutter/cupertino.dart';
import '../tool/api.dart';
import '../tool/loader.dart';
import '../../tool/url.dart';

class ModelItemMedicine {
  late String medicineId;
  late String nameMedicine;
  late String timeTakeId;
  late String typeMedicineId;
  late String typeMedicineName;
  late String amountPerMedicine;
  late String unitSubMedicineId;
  late String unitSubMedicineName;
  late String amountPerMedicineAll;
  late String unitMedicineAllId;
  late String unitMedicineAllName;
  late String periodId;
  late String periodDay;
  late String startDateMedicine;
  late String timeDayId;
  late List<String> timeNum;
  late String imgMedicine;
  late String labelMedicine;


  ModelItemMedicine({
    required this.medicineId,
    required this.nameMedicine,
    required this.timeTakeId,
    required this.typeMedicineId,
    required this.typeMedicineName,
    required this.amountPerMedicine,
    required this.unitSubMedicineId,
    required this.unitSubMedicineName,
    required this.amountPerMedicineAll,
    required this.unitMedicineAllId,
    required this.unitMedicineAllName,
    required this.periodId,
    required this.periodDay,
    required this.startDateMedicine,
    required this.timeDayId,
    required this.timeNum,
    required this.imgMedicine,
    required this.labelMedicine,
  });



  // factory ModelItemMedicine.fromMap(Map<String, dynamic> json) => ModelItemMedicine(
 
    // nameMedicine: json["nameMedicine"],
    // dateTime: DateTime.parse(json["notificationDateTime"]),
    // name: json["name"],
  // );

  // Map<String, dynamic> toMap() => {
  //   "nameMedicine": nameMedicine,
  //   "notificationDateTime": dateTime.toIso8601String(),
  //   "name": name,
  // };


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
  static deleteAlarm(alarmId) async {

    Map<String, dynamic> data  = {
      "register_id":AppUrl.RegisterID,
      "alarm_id": alarmId
    };
    final response = await AppApi.post_Json(
        AppUrl.delete_alarm, data); // เรียกใช้ api
    print(response);
    if (response['statusCode'] == 200) {
      // return true;
      AppLoader.showSuccess('ลบรายการสำเร็จ');
    }
  }
}
