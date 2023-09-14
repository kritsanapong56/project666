import '../tool/api.dart';
import '../../tool/url.dart';

class ModelPeriodMedicine {
  final String periodId;
  final String periodName;

  ModelPeriodMedicine({
    required this.periodId,
    required this.periodName,
  });

  factory ModelPeriodMedicine.fromMap(Map<String, dynamic> json) => ModelPeriodMedicine(
    periodId: json["period_id"],
    periodName: json["period_name"],
  );

  Map<String, dynamic> toMap() => {
    "timeLineId": periodId,
    "name": periodName
  };

  static getPeriod() async {
    final response = await AppApi.post_Json(AppUrl.get_period_of_medicine,{}); // เรียกใช้ api
    return response;
  }
}
