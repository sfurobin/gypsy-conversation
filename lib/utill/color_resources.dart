
import 'package:chat/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorResources {
  static Color getPrimaryColor(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF47B8D6, ) : const Color(0xFF0061FF);
  }
  static Color getGreyColor(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF6f7275) : const Color(0xFF667085);
  }


  static Color getBackgroundColor(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  }



  static Color getHintColor(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF98a1ab) : const Color(0xFF52575C);
  }

  static Color getTextColor(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFFE4E8EC) : const Color(0xFF101828);
  }

  static Color getWhiteColor(BuildContext context){
    return Get.find<ThemeController>().darkTheme ? const Color(0xFFFFFFFF) : const Color(0xFFFFFFFF);
  }

  static const Color colorPrimary = Color(0xFF006EFF);
  static const Color colorLowPrimary = Color(0xFFEBF4FF);
  static const Color colorLessPrimary = Color(0xFFFCF0CA);
  static const Color colorGrey100 = Color(0xFFF2F4F7);
  static const Color colorGrey700 = Color(0xFF344054);
  static const Color colorBlack = Color(0xFF101828);
  static const Color colorBlack600 = Color(0xFF475467);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorLightBlack = Color(0xFF4A4B4D);
  static const Color colorGreen = Color(0xFF12B76A);
  static const Color dividerColor = Color(0xFFEAECF0);
  static const Color subtextColor = Color(0xFF475467);





}
