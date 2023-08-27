import 'package:chat/utill/api_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController  extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;
  LocalizationController({required this.sharedPreferences}) {
    _loadCurrentLanguage();
  }

  Locale _locale = const Locale('en', 'US');
  bool _isLtr = true;
  Locale get locale => _locale;
  bool get isLtr => _isLtr;

  void setLanguage(Locale locale) {
    _locale = locale;
    if(_locale.languageCode == 'ar') {
      _isLtr = false;
    }else {
      _isLtr = true;
    }
    _saveLanguage(_locale);
    Get.updateLocale(locale);
    update();
  }

  _loadCurrentLanguage() async {
    _locale = Locale(
        sharedPreferences.getString(ApiConfig.languageValidCode) ?? 'en',
        sharedPreferences.getString(ApiConfig.countryValidCode) ?? 'US');
    _isLtr = _locale.languageCode == 'en';
    update();
  }

  _saveLanguage(Locale locale) async {
    sharedPreferences.setString(ApiConfig.languageValidCode, locale.languageCode);
    sharedPreferences.setString(ApiConfig.countryValidCode, locale.countryCode!);


  }
}