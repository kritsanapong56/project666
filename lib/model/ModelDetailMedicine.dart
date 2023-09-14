import '../tool/api.dart';
import '../../tool/url.dart';

class ModelDetailMedicine {
  final String medicine_id;
  final String medicine_name;
  final String type_medicine_name;
  final String time_take_name;
  final String time_day_name;
  final String period_name;
  final String amount_unit_sub;
  final String unit_sub_name;
  final String amount_unit_all;
  final String unit_all_name;
  final String img_medicine;

  ModelDetailMedicine({
    required this.medicine_id,
    required this.medicine_name,
    required this.type_medicine_name,
    required this.time_take_name,
    required this.time_day_name,
    required this.period_name,
    required this.amount_unit_sub,
    required this.unit_sub_name,
    required this.amount_unit_all,
    required this.unit_all_name,
    required this.img_medicine,
  });



  factory ModelDetailMedicine.fromMap(Map<String, dynamic> json) => ModelDetailMedicine(
    medicine_id: json["medicine_id"],
    medicine_name: json["medicine_name"],
    type_medicine_name: json["type_medicine_name"],
    time_take_name: json["time_take_name"],
    time_day_name: json["time_day_name"],
    period_name: json["period_name"],
    amount_unit_sub: json["amount_unit_sub"],
    unit_sub_name: json["unit_sub_name"],
    amount_unit_all: json["amount_unit_all"],
    unit_all_name: json["unit_all_name"],
    img_medicine: json["img_medicine"],
  );

  static getMedicineAll() async {
    Map<String, dynamic> data = {
      "register_id": AppUrl.RegisterID
    };
    final response = await AppApi.post_Json(AppUrl.get_medicine_all,data); // เรียกใช้ api
    return response;
  }
}
