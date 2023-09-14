import '../tool/api.dart';
import '../../tool/url.dart';

class ModelTimeTakeMedicine {
  final String timeTakeId;
  final String timeTakeName;

  ModelTimeTakeMedicine({
    required this.timeTakeId,
    required this.timeTakeName,
  });

  factory ModelTimeTakeMedicine.fromJson(Map<String, dynamic> json) => ModelTimeTakeMedicine(
    timeTakeId: json["time_take_id"],
    timeTakeName: json["time_take_name"],
  );

  Map<String, dynamic> toJson() => {
    "timeTakeId": timeTakeId,
    "timeTakeName": timeTakeName
  };

  static getTimeTake() async {
    final response = await AppApi.post_Json(AppUrl.get_time_take_medicine,{}); // เรียกใช้ api
    return response;
  }
}
