// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse loginResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String loginResponseToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
  int status;
  String message;
  Data? data;

  RegisterResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String id;
  String firstname;
  String lastname;
  String username;
  String email;
  String? password;

  Data({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    this.password,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstname: json["first_name"] ?? "",
        lastname: json["last_name"] ?? "",
        username: json["username"] ?? "",
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstname,
        "last_name": lastname,
        "username": username,
        "email": email,
        "password": password,
      };
}
