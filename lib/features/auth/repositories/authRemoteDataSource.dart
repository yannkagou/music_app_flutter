import 'package:client/features/auth/utils/api.dart';

class AuthRemoteDataSource {
  Future<dynamic> login(
      {required String username, required String password}) async {
    try {
      Map<String, dynamic> body = {"username": username, "password": password};
      Map<String, dynamic> result = {};
      result = await Api.post(body: body, endpoint: Api.login);
      return result;
    } catch (e) {
      throw ApiMessageAndCodeException(errorMessage: e.toString());
    }
  }

  Future<dynamic> getUser({String? accessToken}) async {
    try {
      Map<String, dynamic> result = {};
      result = await Api.getMe(
          endpoint: Api.getSubscriber, accessToken: accessToken);
      return result;
    } catch (e) {
      throw ApiMessageAndCodeException(errorMessage: e.toString());
    }
  }
}
