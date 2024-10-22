import 'package:client/core/local_storage/sharedPref.dart';
import 'package:client/core/theme/theme.dart';
import 'package:client/features/auth/cubits/authCubit.dart';
import 'package:client/features/auth/repositories/authRepository.dart';
import 'package:client/features/auth/views/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesServices.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 896),
        builder: (BuildContext context, Widget? child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AuthCubit>(
                  create: (context) =>
                      AuthCubit(AuthRepository(), SharedPreferencesServices())),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: AppTheme.darkThemeMode,
              home: const LoginPage(),
            ),
          );
        });
  }
}
