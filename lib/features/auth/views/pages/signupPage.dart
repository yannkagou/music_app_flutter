import 'package:client/core/constants/app_text_styles.dart';
import 'package:client/core/constants/constants.dart';
import 'package:client/core/constants/kColors.dart';
import 'package:client/features/auth/views/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/views/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
    formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
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
                hintext: Texts.NAME,
                controller: nameController,
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
                hintext: Texts.PASSWORD,
                controller: passwordController,
                isObscureText: true,
              ),
              SizedBox(
                height: 20.h,
              ),
              const AuthGradientButton(text: Texts.SIGNUP),
              SizedBox(
                height: 15.h,
              ),
              RichText(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
