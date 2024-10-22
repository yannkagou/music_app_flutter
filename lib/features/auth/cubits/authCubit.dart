import 'package:client/core/constants/constants.dart';
import 'package:client/core/local_storage/sharedPref.dart';
import 'package:client/core/ui_service/ui.dart';
import 'package:client/features/auth/models/LoginResponse.dart';
import 'package:client/features/auth/models/userModel.dart';
import 'package:client/features/auth/repositories/authRepository.dart';
import 'package:client/features/auth/views/pages/signupPage.dart';
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

  void userLogin({required String email, required String password}) async {
    try {
      emit(AuthFetchInProgress());
      final Map<String, dynamic> result =
          await _authRepository.login(email: email, password: password);
      debugPrint("result ========> $result");
      if (result["status"] == 400) {
        showCustomSnackBar(Texts.ERROR, Texts.INVALID_CREDENTIALS);
        emit(AuthFetchSuccess());
      } else {
        var user = User(
            id: result["data"]["id"].toString(),
            email: result["data"]["email"].toString(),
            firstName: result["data"]["first_name"].toString(),
            lastName: result["data"]["last_name"].toString(),
            username: result["data"]["username"].toString());
        await service.setUserInSharedPref(user);
        g.Get.offAll(() => SignupPage(), transition: g.Transition.upToDown);
        emit(AuthFetchSuccess());
      }
    } catch (e) {
      emit(AuthFetchFailure(e.toString()));
    }
  }
}
