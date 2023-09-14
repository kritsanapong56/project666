import '../tool/api.dart';
import '../../tool/url.dart';

class ModelReport {
  final String date_report;
  final String num_skip;
  final String num_eat;
  final String time_eat;
  final String medicine_name; 

  ModelReport({
    required this.date_report,
    required this.num_skip,
    required this.num_eat,
    required this.time_eat,
    required this.medicine_name, 
  });



  factory ModelReport.fromMap(Map<String, dynamic> json) => ModelReport(
    date_report: json["date_report"],
    num_skip: json["num_skip"],
    num_eat: json["num_eat"],
    time_eat: json["time_eat"],
    medicine_name: json["medicine_name"], 
  );

  static getReport() async {
    Map<String, dynamic> data = {
      "register_id": AppUrl.RegisterID
    };
    final response = await AppApi.post_Json(AppUrl.get_report,data); // เรียกใช้ api
    return response;
  }

  static getReportSkip(skip_time) async {
    Map<String, dynamic> data = {
      "skip_time": skip_time
    };
    final response = await AppApi.post_Json(AppUrl.get_report_alarm_skip,data); // เรียกใช้ api
    return response;
  }

  static getReportEat(eat_time) async {
    Map<String, dynamic> data = {
      "eat_time": eat_time
    };
    final response = await AppApi.post_Json(AppUrl.get_report_alarm_eat,data); // เรียกใช้ api
    return response;
  }

  static addReportSkip(medicine_id,remark) async {
    Map<String, dynamic> data = {
      "medicine_id": medicine_id,
      "remark": remark,
    };
    final response = await AppApi.post_Json(AppUrl.insert_alarm_skip,data); // เรียกใช้ api
    return response;
  }

  static addReportEat(medicine_id) async {
    Map<String, dynamic> data = {
      "medicine_id": medicine_id
    };
    final response = await AppApi.post_Json(AppUrl.insert_alarm_eat,data); // เรียกใช้ api
    return response;
  }
}
