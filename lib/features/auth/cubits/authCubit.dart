import 'package:client/core/constants/constants.dart';
import 'package:client/core/local_storage/sharedPref.dart';
import 'package:client/core/ui_service/ui.dart';
import 'package:client/features/auth/models/AccessToken.dart';
import 'package:client/features/auth/models/LoginResponse.dart';
import 'package:client/features/auth/models/userModel.dart';
import 'package:client/features/auth/repositories/authRepository.dart';
import 'package:client/features/auth/views/pages/loginPage.dart';
import 'package:client/features/auth/views/pages/signupPage.dart';
import 'package:client/features/home/views/pages/upload_song_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as g;

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthFetchInProgress extends AuthState {}

class AuthFetchSuccess extends AuthState {
  LoginResponse? authResponse;

  AuthFetchSuccess({
    this.authResponse,
  });
}

class AuthFetchFailure extends AuthState {
  final String errorMessage;

  AuthFetchFailure(
    this.errorMessage,
  );
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final SharedPreferencesServices service;

  AuthCubit(this._authRepository, this.service) : super(AuthInitial());

  Future<void> userLogin({
    required String username,
    required String password,
  }) async {
    try {
      emit(AuthFetchInProgress());
      final Map<String, dynamic> result =
          await _authRepository.login(username: username, password: password);
      // debugPrint("result ========> $result");
      // debugPrint("result ========> ${result['auth_token']}");
      if (result["auth_token"] != null) {
        String accessToken = AccessToken.fromJson(result).authToken;
        // debugPrint("accesstoken ========> $accessToken");
        await service.setAccessToken(accessToken);
        // debugPrint(
        //     "accesstoken ========> ${service.getAccessTokenFromSharedPref()}");
        emit(AuthFetchSuccess());
      } else {
        showCustomSnackBar(Texts.ERROR, Texts.INVALID_CREDENTIALS);
        // debugPrint("no accesstoken ========>");
        // const SnackBar(content: Text("Error"));
        emit(AuthFetchSuccess());
      }
    } catch (e) {
      emit(AuthFetchFailure(e.toString()));
    }
  }

  Future<void> userRegister({
    required String username,
    required String email,
    required String firstname,
    required String lastname,
    required String password,
  }) async {
    try {
      emit(AuthFetchInProgress());
      final Map<String, dynamic> result = await _authRepository.register(
          username: username,
          email: email,
          password: password,
          firstname: firstname,
          lastname: lastname);
      if (result["id"] != null) {
        g.Get.to(() => const LoginPage(), transition: g.Transition.upToDown);
        emit(AuthFetchSuccess());
      } else {
        showCustomSnackBar(Texts.ERROR, Texts.INVALID_CREDENTIALS);
      }
    } catch (e) {
      emit(AuthFetchFailure(e.toString()));
    }
  }

  Future<void> getUser({String? accessToken}) async {
    try {
      emit(AuthFetchInProgress());
      final Map<String, dynamic> result =
          await _authRepository.getUser(accessToken: accessToken);
      // debugPrint("result ========> $result");
      if (result["id"] != null) {
        var user = User(
            id: result["id"].toString(),
            email: result["user"]["email"].toString(),
            firstName: result["user"]["first_name"].toString(),
            lastName: result["user"]["last_name"].toString(),
            username: result["user"]["username"].toString());
        await service.setUserInSharedPref(user);
        // debugPrint("user ========> ${service.getUserFromSharedPref()}");
        g.Get.to(() => const UploadSongPage(),
            transition: g.Transition.upToDown);
        emit(AuthFetchSuccess());
      } else {
        showCustomSnackBar(Texts.ERROR, Texts.INVALID_CREDENTIALS);
        // const SnackBar(content: Text("Error"));
        emit(AuthFetchSuccess());
      }
    } catch (e) {
      emit(AuthFetchFailure(e.toString()));
    }
  }
}
