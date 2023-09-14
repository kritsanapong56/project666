import '../tool/api.dart';
import '../../tool/url.dart';

class ModelReportEat {
  final String medicine_name;
  final String eat_time;

  ModelReportEat({
    required this.medicine_name,
    required this.eat_time,
  });



  factory ModelReportEat.fromMap(Map<String, dynamic> json) => ModelReportEat(
    medicine_name: json["medicine_name"],
    eat_time: json["eat_time"],
  );
}
