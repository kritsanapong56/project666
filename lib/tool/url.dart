

import 'package:flutter_alarm_safealert/model/ModelRegister.dart';

import '../model/ModelItemMedicine.dart';

class AppUrl {

  static String RegisterID = '';
  static String FCM_token= '';
  static ModelItemMedicine objAddItemMedicine =
  ModelItemMedicine(
    medicineId: "",
    nameMedicine: "",
    timeTakeId: "",
    typeMedicineId: "",
    typeMedicineName: "",
    amountPerMedicine: "",
    unitSubMedicineId: "",
    unitSubMedicineName: "",
    amountPerMedicineAll: "",
    unitMedicineAllId: "",
    unitMedicineAllName: "",
    periodId: "",
    periodDay: "",
    startDateMedicine: "",
    timeDayId: "",
    timeNum: ["08:00","12:00","20:00"],
    imgMedicine: "",
    labelMedicine: "", );

  static ModelRegister objRegister =
  ModelRegister(
      register_id: "",
      name: "",
      date_of_birth: "",
      gender_name: "",
      img_profile:""
  );
  static const String SAFE_ALERT_URL ="https://abl-bot.com/safe_alert/";

  static const String Path_ImageHistoryApp = SAFE_ALERT_URL + "/ImageHistoryApp/";

  static const String Connect_database = SAFE_ALERT_URL + "app_connect.php";
  static const String update_fcm_token = SAFE_ALERT_URL + "update_fcm_token.php";
  static const String get_profile_register = SAFE_ALERT_URL + "get_profile_register.php";
  static const String update_date_next_appointment = SAFE_ALERT_URL + "update_date_next_appointment.php";
  //บันทึกข้อมูลการรักษา
  static const String insert_data_help = SAFE_ALERT_URL + "insert_data_help.php";
  static const String get_data_treatment = SAFE_ALERT_URL + "get_data_treatment.php";
  static const String update_data_treatment = SAFE_ALERT_URL + "update_data_treatment.php";
  static const String delete_data_treatment = SAFE_ALERT_URL + "delete_data_treatment.php";

  //แจ้งเตือน
  static const String insert_data_alarm = SAFE_ALERT_URL + "insert_data_alarm.php";
  static const String update_data_alarm = SAFE_ALERT_URL + "update_data_alarm.php";
  // static const String get_data_alarm = SAFE_ALERT_URL + "get_data_alarm.php";
  static const String get_data_alarm = SAFE_ALERT_URL + "get_list_data_alarm.php";


  static const String register_safe_alert = SAFE_ALERT_URL + "register_safe_alert.php";
  static const String get_time_take_medicine = SAFE_ALERT_URL + "get_time_take_medicine.php";
  static const String get_type_medicine = SAFE_ALERT_URL + "get_type_medicine.php";
  static const String get_period_of_medicine = SAFE_ALERT_URL + "get_period_of_medicine.php";
  static const String get_time_day_medicine = SAFE_ALERT_URL + "get_time_day_medicine.php";
  static const String insert_medicine = SAFE_ALERT_URL + "insert_medicine.php";
  static const String insert_alarm = SAFE_ALERT_URL + "insert_alarm.php";
  static const String get_medicine_today = SAFE_ALERT_URL + "get_medicine_today.php";
  static const String get_medicine_all= SAFE_ALERT_URL + "get_medicine_all.php";
  static const String get_report = SAFE_ALERT_URL + "get_report.php";
  static const String get_report_alarm_skip = SAFE_ALERT_URL + "get_report_alarm_skip.php";
  static const String get_report_alarm_eat = SAFE_ALERT_URL + "get_report_alarm_eat.php";
  static const String insert_alarm_skip = SAFE_ALERT_URL + "insert_alarm_skip.php";
  static const String insert_alarm_eat = SAFE_ALERT_URL + "insert_alarm_eat.php";
  static const String get_medicine_next_alarm = SAFE_ALERT_URL + "get_medicine_next_alarm.php";
  static const String update_profile_register = SAFE_ALERT_URL + "update_profile_register.php";
  static const String upload_img_medicine = SAFE_ALERT_URL + "upload_img_medicine.php";
  static const String update_time_snooze = SAFE_ALERT_URL + "update_time_snooze.php";
  static const String delete_alarm = SAFE_ALERT_URL + "delete_alarm.php";

}
