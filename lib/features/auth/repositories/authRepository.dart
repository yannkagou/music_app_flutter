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
      {required String email, required String password}) async {
    final result =
        await _authRemoteDataSource.login(email: email, password: password);
    return result;
  }
}
