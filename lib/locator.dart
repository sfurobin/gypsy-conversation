import 'dart:convert';

import 'package:chat/controller/language_controller.dart';
import 'package:chat/controller/localization_controller.dart';
import 'package:chat/controller/theme_controller.dart';
import 'package:chat/data/repository/language_repo.dart';
import 'package:chat/data/response/language_model.dart';
import 'package:chat/helper/remote/api_client.dart';
import 'package:chat/utill/api_config.dart';
import 'package:chat/view/features/home/controller/home_controller.dart';
import 'package:chat/view/features/home/data/repo/home_repo.dart';
import 'package:chat/view/features/message_box/controller/inbox_controller.dart';
import 'package:chat/view/features/message_box/data/repo/inbox_repo.dart';
import 'package:chat/view/features/user_details/controller/user_details_controller.dart';
import 'package:chat/view/features/user_details/data/repo/user_details_repo.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: ApiConfig.baseUrl,  sharedPreferences: Get.find()));
  // Core

  // Request
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => HomeRepo());
  Get.lazyPut(() => InboxRepo());
  Get.lazyPut(() => UserDetailsRepo());


  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LanguageController(languageRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => HomeController(homeRepo: Get.find()));
  Get.lazyPut(() => InboxController(inboxRepo: Get.find()));
  Get.lazyPut(() => UserDetailsController(userDetailsRepo: Get.find()));


  /// read from json file
  Map<String, Map<String, String>> langFiles = {};
  for(LanguageModel languageModel in ApiConfig.languages) {
    String jsonToString =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonToString);
    Map<String, String> convertToJson = {};
    mappedJson.forEach((key, value) {
      convertToJson[key] = value.toString();
    });
    langFiles['${languageModel.languageCode}_${languageModel.countryCode}'] = convertToJson;
  }
  return langFiles;
}