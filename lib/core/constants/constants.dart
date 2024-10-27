// ignore_for_file: constant_identifier_names

import 'dart:io';

class Texts {
  static const String SIGNUP_TITLE = "Sign Up.";
  static const String SIGNIN_TITLE = "Sign In.";
  static const String EMAIL = "Email";
  static const String USERNAME = "Username";
  static const String PASSWORD = "Password";
  static const String FIRSTNAME = "Firstname";
  static const String LASTNAME = "Lastname";
  static const String SIGNUP = "Sign Up";
  static const String SIGNIN = "Sign In";
  static const String ALREADY_ACCOUNT = "Already have an account? ";
  static const String NO_ACCOUNT = "Don't have an account? ";
  static const String ERROR = "Error";
  static const String UNEXPECTED_ERROR =
      "Something went wrong! Try again later.";
  static const String INVALID_CREDENTIALS =
      "Sorry ! Email or Password is wrong";
  static const String ALL_FIELD_REQUIRED = "All fields are required";
  static const String UPLOAD_SONG = "Upload Song";
  static const String SELECT_SONG_THUMBNAIL =
      "Select the thumbnail for your Song";
  static const String PICK_SONG = "Pick Song";
  static const String SONG_NAME = "Song Name";
  static const String ARTIST = "Artist";
}

class URLS {
  static String? auth = Platform.isAndroid
      ? "http://10.0.2.2:8000/auth"
      : "http://127.0.0.1:8000/auth";

  static String? api = Platform.isAndroid
      ? "http://10.0.2.2:8000/api"
      : "http://127.0.0.1:8000/api";
}
