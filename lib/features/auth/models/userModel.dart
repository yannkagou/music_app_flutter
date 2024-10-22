import 'dart:convert';

class User {
  String? firstName;
  String? lastName;
  String? email;
  String? id;
  String? password;
  String? username;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.id,
    this.password,
    this.username,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        id: json["id"],
        username: json["username"],
      );

  Map<String, dynamic> toMap() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "id": id,
        "username": username,
      };
}
