import '../tool/api.dart';
import '../../tool/url.dart';

class ModelDayMedicine {
  final String timeDayId;
  final String timeDayName;

  ModelDayMedicine({
    required this.timeDayId,
    required this.timeDayName,
  });

  factory ModelDayMedicine.fromMap(Map<String, dynamic> json) => ModelDayMedicine(
    timeDayId: json["time_day_id"],
    timeDayName: json["time_day_name"],
  );

  Map<String, dynamic> toMap() => {
    "timeLineId": timeDayId,
    "name": timeDayName
  };

  static getTimeDay() async {
    final response = await AppApi.post_Json(AppUrl.get_time_day_medicine,{}); // เรียกใช้ api
    return response;
  }
}
