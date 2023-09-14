class ModelMedicine {
  final int? id;
  final String messageDateTime;
  final DateTime dateTime;
  final String name;

  ModelMedicine({
    this.id,
    required this.messageDateTime,
    required this.dateTime,
    required this.name,
  });



  factory ModelMedicine.fromMap(Map<String, dynamic> json) => ModelMedicine(
    id: json["id"],
    messageDateTime: json["messageDateTime"],
    dateTime: DateTime.parse(json["notificationDateTime"]),
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "messageDateTime": messageDateTime,
    "notificationDateTime": dateTime.toIso8601String(),
    "name": name,
  };
}
