import '../tool/api.dart';
import '../../tool/url.dart';

class ModelMedicineAlarmNext {
  final String alarm_id;
  final String medicine_name;
  final String msg_alarm;
  final String sum_medicine;

  ModelMedicineAlarmNext({
    required this.alarm_id,
    required this.medicine_name,
    required this.msg_alarm,
    required this.sum_medicine,
  });



  factory ModelMedicineAlarmNext.fromMap(Map<String, dynamic> json) => ModelMedicineAlarmNext(
    alarm_id: json["alarm_id"],
    medicine_name: json["medicine_name"],
    msg_alarm: json["msg_alarm"],
    sum_medicine: json["sum_medicine"],
  );

  static getMedicineAlarmNext() async {
    Map<String, dynamic> data = {
      "register_id": AppUrl.RegisterID
    };
    final response = await AppApi.post_Json(AppUrl.get_medicine_next_alarm,data); // เรียกใช้ api
    return response;
  }
}
