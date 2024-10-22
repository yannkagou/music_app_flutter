import 'package:client/features/auth/utils/api.dart';

class AuthRemoteDataSource {
  Future<dynamic> login(
      {required String email, required String password}) async {
    try {
      Map<String, dynamic> body = {"email": email, "password": password};
      Map<String, dynamic> result = {};
      result = await Api.post(body: body, endpoint: Api.login);
      return result;
    } catch (e) {
      throw ApiMessageAndCodeException(errorMessage: e.toString());
    }
  }

  Future<dynamic> getUser({String? accessToken}) async {
    try {
      Map<String, dynamic> body = {};
      Map<String, dynamic> result = {};
      result = await Api.authenticatedPost(
          body: body, endpoint: Api.getUser, accessToken: accessToken);
      return result;
    } catch (e) {
      throw ApiMessageAndCodeException(errorMessage: e.toString());
    }
  }
}
