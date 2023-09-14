import '../tool/api.dart';
import '../../tool/url.dart';

class ModelTypeMedicine {
  final String typeMedicineId;
  final String typeMedicineName;
  final String another;

  ModelTypeMedicine({
    required this.typeMedicineId,
    required this.typeMedicineName,
    required this.another,
  });

  factory ModelTypeMedicine.fromMap(Map<String, dynamic> json) => ModelTypeMedicine(
    typeMedicineId: json["type_medicine_id"],
    typeMedicineName: json["type_medicine_name"],
    another: json["another"],
  );

  Map<String, dynamic> toMap() => {
    "typeId": typeMedicineId,
    "typeMedicineName": typeMedicineName
  };

  static getTypeMedicine() async {
    final response = await AppApi.post_Json(AppUrl.get_type_medicine,{}); // เรียกใช้ api
    return response;
  }
}
