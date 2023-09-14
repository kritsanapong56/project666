import '../tool/api.dart';
import '../../tool/url.dart';

class ModelReportSkip {
  final String medicine_name;
  final String skip_time;

  ModelReportSkip({
    required this.medicine_name,
    required this.skip_time,
  });



  factory ModelReportSkip.fromMap(Map<String, dynamic> json) => ModelReportSkip(
    medicine_name: json["medicine_name"],
    skip_time: json["skip_time"],
  );
}
