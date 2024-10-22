import 'dart:convert';

AccessToken loginResponseFromJson(String str) =>
    AccessToken.fromJson(json.decode(str));

String loginResponseToJson(AccessToken data) => json.encode(data.toJson());

class AccessToken {
  final String authToken;

  AccessToken({
    required this.authToken,
  });

  factory AccessToken.fromJson(Map<String, dynamic> json) => AccessToken(
        authToken: json["auth_token"],
      );

  Map<String, dynamic> toJson() => {
        "auth_token": authToken,
      };
}