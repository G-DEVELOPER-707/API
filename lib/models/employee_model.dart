// // To parse this JSON data, do
// //
// //     final employee = employeeFromJson(jsonString);
//
// import 'dart:convert';
// //
// // // Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));
// // //
// // // String employeeToJson(Employee data) => json.encode(data.toJson());
// //
// class EmployeeModel {
//   EmployeeModel({
//     required this.userId,
//   });
// //
//   List<Datum> userId;
// //   //
// //   // factory Employee.fromJson(Map<String, dynamic> json) => Employee(
// //   //   status: json["status"],
// //   //   data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
// //   //   message: json["message"],
// //   // );
// //
// //   // Map<String, dynamic> toJson() => {
// //   //   "status": status,
// //   //   "data": List<dynamic>.from(data.map((x) => x.toJson())),
// //   //   "message": message,
// //   // };
// // }
// //
// // class Datum {
// //   Datum({
// //     required this.id,
// //     required this.userId,
// //     required this.title,
// //     required this.body,
// //   });
// //
// //   int id;
// //   String userId;
// //   int title;
// //   int body;
//
//   // factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//   //   id: json["id"],
//   //   userId: json["userId"],
//   //   title: json["title"],
//   //   body: json["body"],
//   // );
//
//   // Map<String, dynamic> toJson() => {
//   //   "id": id,
//   //   "userId": userId,
//   //   "title": title,
//   //   "body": body,
//   // };
//   Map<String, dynamic> mapId() => {
//     "id": userId,
//     "list": List<listModel>,
//   };
// }
//
// class listModel {
//   listModel({
//     required this.id,
//     required this.userId,
//     required this.title,
//     required this.body,
//   });
//
//   int id;
//   String userId;
//   int title;
//   int body;
// }
import 'dart:convert';

EmployeeModel employeeFromJson(String str) => EmployeeModel.fromJson(json.decode(str));

String employeeToJson(EmployeeModel data) => json.encode(data.toJson());

class EmployeeModel {
  EmployeeModel({
    required this.listUserId,
    required this.userId
  });

  List<Datum> listUserId;
  String userId;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    userId: json["userId"],
    listUserId: List<Datum>.from(json["listUserId"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "listUserId": List<dynamic>.from(listUserId.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.body,
    required this.userId
  });

  int id;
  String userId;
  int title;
  int body;


  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    body: json["body"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": userId,
    "list": List<Datum>,
  };

}