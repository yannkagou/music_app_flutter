import 'package:client/features/auth/repositories/authRemoteDataSource.dart';

class AuthRepository {
  static final AuthRepository _authRepository = AuthRepository._internal();
  late AuthRemoteDataSource _authRemoteDataSource;

  factory AuthRepository() {
    _authRepository._authRemoteDataSource = AuthRemoteDataSource();
    return _authRepository;
  }

  AuthRepository._internal();

  Future<dynamic> login(
      {required String username, required String password}) async {
    final result = await _authRemoteDataSource.login(
        username: username, password: password);
    return result;
  }

  Future<dynamic> getUser({required accessToken}) async {
    final result =
        await _authRemoteDataSource.getUser(accessToken: accessToken);
    return result;
  }

  Future<dynamic> register(
      {required String username,
      required String email,
      required String password,
      String? firstname,
      String? lastname}) async {
    final result = await _authRemoteDataSource.register(
        username: username,
        email: email,
        password: password,
        firstname: firstname,
        lastname: lastname);
    return result;
  }
}
