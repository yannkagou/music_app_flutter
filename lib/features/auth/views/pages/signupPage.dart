import 'package:client/core/constants/app_text_styles.dart';
import 'package:client/core/constants/constants.dart';
import 'package:client/core/constants/kColors.dart';
import 'package:client/core/ui_service/FormValidator.dart';
import 'package:client/core/ui_service/circularProgressIndicator.dart';
import 'package:client/core/ui_service/ui.dart';
import 'package:client/features/auth/cubits/authCubit.dart';
import 'package:client/features/auth/utils/internetConnectivity.dart';
import 'package:client/features/auth/views/pages/loginPage.dart';
import 'package:client/features/auth/views/widgets/auth_gradient_button.dart';
import 'package:client/core/widget/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    emailController.dispose();
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
            showCustomSnackBar(Texts.ERROR, state.errorMessage);
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
                      Texts.SIGNUP_TITLE,
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
                      hintext: Texts.EMAIL,
                      controller: emailController,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomField(
                      hintext: Texts.FIRSTNAME,
                      controller: firstnameController,
                      isObscureText: true,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomField(
                      hintext: Texts.LASTNAME,
                      controller: lastnameController,
                      isObscureText: true,
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
                    AuthGradientButton(text: Texts.SIGNUP, onTap: () {}),
                    SizedBox(
                      height: 15.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: RichText(
                        text: TextSpan(
                            text: Texts.ALREADY_ACCOUNT,
                            style: Theme.of(context).textTheme.titleMedium,
                            children: const [
                              TextSpan(
                                  text: Texts.SIGNIN,
                                  style: TextStyle(
                                      color: Kcolors.gradient2,
                                      fontWeight: FontWeight.bold))
                            ]),
                      ),
                    ),
                    if (state is AuthFetchInProgress) showCircularProgress(true)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _registerForm() async {
    FocusScope.of(context).unfocus();
    if (FormValidator.isEmptyFields([
      usernameController.text,
      emailController.text,
      passwordController.text
    ])) {
      return;
    }

    if (await InternetConnectivity.isNetworkAvailable()) {
      context.read<AuthCubit>().userRegister(
          username: usernameController.text,
          email: emailController.text,
          firstname: firstnameController.text,
          lastname: lastnameController.text,
          password: passwordController.text);
    } else {
      const SnackBar(content: Text("Error"));
    }
  }
}
