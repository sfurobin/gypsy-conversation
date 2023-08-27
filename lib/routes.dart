import 'package:chat/view/features/home/view/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String main = '/';

  static const String splashScreen = '/splash';
  static const String landingScreen = '/landing';


  static String getSplashRoute() => splashScreen;
  static String getLandingRoute() => landingScreen;
  static String getMainRoute() => '$main?page=';


  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () =>  Container()),
    GetPage(name: landingScreen, page: () =>  Container()),
    GetPage(name: main, page: () =>  const ChatHomeScreen()),
  ];
}
