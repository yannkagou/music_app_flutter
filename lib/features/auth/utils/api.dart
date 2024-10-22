import 'dart:convert';
import 'dart:io';

import 'package:client/core/constants/constants.dart';
import 'package:client/core/ui_service/ui.dart';
import 'package:client/features/auth/utils/errorMesageKeys.dart';
import 'package:client/features/auth/utils/internetConnectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiMessageAndCodeException implements Exception {
  final String errorMessage;

  ApiMessageAndCodeException({required this.errorMessage});

  Map toError() => {"message": errorMessage};

  @override
  String toString() => errorMessage;
}

class ApiException implements Exception {
  String errorMessage;

  ApiException(this.errorMessage);

  @override
  String toString() {
    // TODO: implement toString
    return errorMessage;
  }
}

class Api {
  static String login = "auth/token/login";
  static String register = "auth/users";

  static Map<String, String> get headers => {
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
        "Connection": "keep-alive"
      };

  static Future<dynamic> post({
    required Map<String, dynamic> body,
    required String endpoint,
  }) async {
    try {
      if (await InternetConnectivity.isNetworkAvailable() == false) {
        throw const SocketException(ErrorMessageKeys.noInternet);
      }
      final Dio dio = Dio();
      String _url = "${URLS.insData}/$endpoint";
      debugPrint("Requested APi - $_url & params are $body");

      final response = await dio.post(_url,
          data: jsonEncode(body),
          options: Options(headers: headers, responseType: ResponseType.json));
      debugPrint("Requested APi status code - ${response.statusCode}");
      debugPrint("response =====>${response.data}");
      if (response.statusCode == 500) {
        debugPrint("APi exception msg - ${response.data}");
        showCustomSnackBar(Texts.ERROR, Texts.UNEXPECTED_ERROR);
        throw ApiException(response.data);
      }
      return response.data;
    } on DioException catch (e) {
      debugPrint("Dio Error - ${e.toString()}");
      throw ApiException(e.error is SocketException
          ? ErrorMessageKeys.noInternet
          : ErrorMessageKeys.defaultErrorMessage);
    } on SocketException catch (e) {
      debugPrint("Socket exception - ${e.toString()}");
      throw SocketException(e.message);
    } on ApiException catch (e) {
      debugPrint("APi Exception - ${e.toString()}");
      throw ApiException(e.errorMessage);
    } catch (e) {
      debugPrint("catch exception- ${e.toString()}");
      throw ApiException(ErrorMessageKeys.defaultErrorMessage);
    }
  }
}
