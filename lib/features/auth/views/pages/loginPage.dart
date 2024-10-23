import 'package:client/core/constants/app_text_styles.dart';
import 'package:client/core/constants/constants.dart';
import 'package:client/core/constants/kColors.dart';
import 'package:client/core/local_storage/sharedPref.dart';
import 'package:client/core/ui_service/FormValidator.dart';
import 'package:client/core/ui_service/circularProgressIndicator.dart';
import 'package:client/core/ui_service/ui.dart';
import 'package:client/features/auth/cubits/authCubit.dart';
import 'package:client/features/auth/utils/errorMesageKeys.dart';
import 'package:client/features/auth/utils/internetConnectivity.dart';
import 'package:client/features/auth/views/pages/signupPage.dart';
import 'package:client/features/auth/views/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/views/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  SharedPreferencesServices service = SharedPreferencesServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
    formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthFetchFailure) {
            // showCustomSnackBar(Texts.ERROR, state.errorMessage);
            const SnackBar(content: Text("Error"));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Texts.SIGNIN_TITLE,
                      style: TextStyles.headerStyle,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomField(
                      hintext: Texts.USERNAME,
                      controller: usernameController,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomField(
                      hintext: Texts.PASSWORD,
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AuthGradientButton(text: Texts.SIGNIN, onTap: _submitForm),
                    SizedBox(
                      height: 15.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupPage()));
                      },
                      child: RichText(
                        text: TextSpan(
                            text: Texts.NO_ACCOUNT,
                            style: Theme.of(context).textTheme.titleMedium,
                            children: const [
                              TextSpan(
                                  text: Texts.SIGNUP,
                                  style: TextStyle(
                                      color: Kcolors.gradient2,
                                      fontWeight: FontWeight.bold))
                            ]),
                      ),
                    ),
                    if (state is AuthFetchInProgress)
                      showCircularProgress(true),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _submitForm() async {
    FocusScope.of(context).unfocus();
    String? accessToken = service.getAccessTokenFromSharedPref();
    if (FormValidator.isEmptyFields(
        [usernameController.text, passwordController.text])) {
      return;
    }

    if (await InternetConnectivity.isNetworkAvailable()) {
      await context.read<AuthCubit>().userLogin(
            username: usernameController.text,
            password: passwordController.text,
          );
      await context.read<AuthCubit>().getUser(accessToken: accessToken);
    } else {
      const SnackBar(content: Text("Error"));
    }
  }
}
