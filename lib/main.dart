import 'package:client/core/local_storage/sharedPref.dart';
import 'package:client/core/theme/theme.dart';
import 'package:client/features/auth/cubits/authCubit.dart';
import 'package:client/features/auth/repositories/authRepository.dart';
import 'package:client/features/auth/views/pages/loginPage.dart';
import 'package:client/features/home/views/pages/upload_song_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesServices.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final service = SharedPreferencesServices();
    String? accessToken = service.getAccessTokenFromSharedPref();
    return ScreenUtilInit(
        designSize: const Size(414, 896),
        builder: (BuildContext context, Widget? child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AuthCubit>(
                  create: (context) =>
                      AuthCubit(AuthRepository(), SharedPreferencesServices())),
            ],
            child: GetMaterialApp(
              title: 'Flutter Demo',
              theme: AppTheme.darkThemeMode,
              home: accessToken != null
                  ? const UploadSongPage()
                  : const LoginPage(),
            ),
          );
        });
  }
}
