import 'package:client/core/constants/kColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static final headerStyle =
      GoogleFonts.overpass(fontSize: 58.sp, fontWeight: FontWeight.bold);
  static final normalWhite = GoogleFonts.overpass(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      color: Kcolors.whiteColor);
  static final buttonWhite = GoogleFonts.overpass(
      fontSize: 17.sp, fontWeight: FontWeight.w600, color: Kcolors.whiteColor);
}
