import 'package:client/core/theme/theme.dart';
import 'package:client/features/auth/views/pages/signupPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 896),
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: AppTheme.darkThemeMode,
            home: const SignupPage(),
          );
        });
  }
}
