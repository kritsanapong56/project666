import 'package:flutter/widgets.dart';
import '../tool/api.dart';
import '../tool/loader.dart';
import '../../tool/url.dart';

class ModelRegister {
  var register_id;
  var name;
  var date_of_birth;
  var gender_name;
  var img_profile;

  ModelRegister (
      {required this.register_id,
        required  this.date_of_birth,
        required  this.name,
        required  this.gender_name,
        required  this.img_profile, });

  static getData() async {
    Map<String, dynamic> data  = {
      "register_id": AppUrl.RegisterID
    };

      final response = await AppApi.post_Json(AppUrl.get_profile_register,data); // เรียกใช้ api
      return response;
  }


  static saveData(context, Map<String, dynamic> data) async {
    final response =
    await AppApi.post(AppUrl.update_profile_register, data); // เรียกใช้ api
    print(response);
    if (response['statusCode'] == 200) {
      //Nav.push(context, Schedule());
    }
  }

  static updateData(context, Map<String, dynamic> data) async {
    final response = await AppApi.post_Json(
        AppUrl.update_profile_register, data); // เรียกใช้ api
    print(response);
    if (response['statusCode'] == 200) {

      Navigator.pop(context);
      AppLoader.showSuccess("บันทึกรายการสำเร็จ");
    }
  }
  static updateDataNextDate(context, Map<String, dynamic> data) async {
    final response = await AppApi.post_Json(
        AppUrl.update_date_next_appointment, data); // เรียกใช้ api
    print(response);
    if (response['statusCode'] == 200) {
      AppLoader.showSuccess("แก้ไขวันที่นัดครั้งต่อไปสำเร็จ");
      // EasyLoading.showSuccess("แก้ไขสำเร็จ");
      // Navigator.pop(context);
    }
  }


  //
  // static delete(context, Map<String, dynamic> data) async {
  //   final response = await AppApi.postWithMap(
  //       AppUrl.ModelRegister_Delete, data); // เรียกใช้ api
  //   print(response);
  //   if (response['statusCode'] == 200) {
  //     return true;
  //   }
  // }

  static List<ModelRegister> dataList = []; // ตัวแปรที่จะเรียกใช้งาน
  static List<ModelRegister> data = []; // ตัวแปรที่จะเรียกใช้งาน

  ModelRegister.fromJson(Map<String, dynamic> json) {
    register_id = json['register_id'];
    date_of_birth = json['date_hbd'];
    name = json['name'];
    gender_name = json['gender'];
    img_profile = json['img_profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['register_id'] = this.register_id;
    data['date_of_birth'] = this.date_of_birth;
    data['name'] = this.name;
    data['gender_name'] = this.gender_name;
    data['img_profile'] = this.img_profile;
    return data;
  }
}
