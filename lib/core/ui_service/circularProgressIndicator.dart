import 'package:client/core/constants/kColors.dart';
import 'package:flutter/cupertino.dart';

Widget showCircularProgress(bool isProgress) {
  if (isProgress) {
    return const Center(
        child: CupertinoActivityIndicator(
      color: Kcolors.gradient3,
      radius: 35,
    ));
  }
  return const SizedBox.shrink();
}

Widget showColoredCircularProgress({required bool isProgress, Color? color}) {
  if (isProgress) {
    return Center(
        child: CupertinoActivityIndicator(
      color: color ?? Kcolors.gradient3,
      radius: 45,
    ));
  }
  return const SizedBox.shrink();
}
