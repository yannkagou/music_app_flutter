import 'package:client/core/constants/app_text_styles.dart';
import 'package:client/core/constants/kColors.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String text;
  const AuthGradientButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Kcolors.gradient1,
            Kcolors.gradient2,
          ],
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(395, 555),
            backgroundColor: Kcolors.transparentColor,
            shadowColor: Kcolors.transparentColor),
        child: Text(
          text,
          style: TextStyles.buttonWhite,
        ),
      ),
    );
  }
}
