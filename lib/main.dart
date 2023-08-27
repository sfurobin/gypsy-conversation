import 'package:chat/controller/language_controller.dart';
import 'package:chat/controller/localization_controller.dart';
import 'package:chat/controller/theme_controller.dart';
import 'package:chat/localization/app_localization.dart';
import 'package:chat/routes.dart';
import 'package:chat/theme/dark_theme.dart';
import 'package:chat/theme/light_theme.dart';
import 'package:chat/utill/api_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'locator.dart' as di;
import 'dart:ui' as ui;

import 'local_string/local_string.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark));
  WidgetsFlutterBinding.ensureInitialized();

  Map<String, Map<String, String>> localString = await di.init();
  runApp( MyApp(localString: localString));
}

class MyApp extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  final Map<String, Map<String, String>> localString;
  const MyApp({Key? key, required this.localString}) : super(key: key);



  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) => GetBuilder<ThemeController>(builder: (theme) {
        return GetBuilder<LocalizationController>(builder: (local) {
          return GetMaterialApp(
            // translations: Languages(),
            locale: local.locale,
            // locale: Get.deviceLocale,
            translations: LocaleString(localString: widget.localString),
            // fallbackLocale: Locale(AppConstants.languages[0].languageCode, AppConstants.languages[0].countryCode),
            fallbackLocale: const Locale('en', 'US'),
            title: ApiConfig.appName,
            initialRoute: RouteHelper.main,
            defaultTransition: Transition.topLevel,
            transitionDuration: const Duration(milliseconds: 500),
            getPages: RouteHelper.routes,
            navigatorKey: Get.key,
            theme: theme.darkTheme ? dark : light,
            debugShowCheckedModeBanner: false,
          );
        });
      }),
    );
  }



  Locale? getLocal(){
    ui.Locale currentLocale = ui.window.locale;
    Locale? local;
   if(Get.find<LanguageController>().deviceLanguage){
    Get.find<LanguageController>().setSelectIndex(0);
     if (currentLocale.languageCode == "de") {
        local = Locale(
         ApiConfig.languages[1].languageCode ?? '',
         ApiConfig.languages[1].countryCode,
       );
     } else {
        local = Locale(
         ApiConfig.languages[0].languageCode ?? '',
         ApiConfig.languages[0].countryCode,
       ) ;
     }
   }else{
     if(Get.find<LocalizationController>().locale.languageCode == 'en'){
       Get.find<LanguageController>().setSelectIndex(1);
       local = Locale(
         ApiConfig.languages[0].languageCode ?? '',
         ApiConfig.languages[0].countryCode,
       );
     }else if (Get.find<LocalizationController>().locale.languageCode == 'de') {
       Get.find<LanguageController>().setSelectIndex(2);
       local = Locale(
         ApiConfig.languages[1].languageCode ?? '',
         ApiConfig.languages[1].countryCode,
       );
     }
   }
   return local;
  }
}