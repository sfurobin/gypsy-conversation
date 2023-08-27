

import 'package:chat/data/response/language_model.dart';

class ApiConfig{
 static const String mediaBaseUrl =  'http://51.159.111.59:8085';
 static const String baseUrl =  'http://51.159.111.59:8085/api';

  // Shared Key
  static const String appName = 'Gypsy Chat';
  static const String theme = 'theme';
  static const String token = 'token';
  static const String userId = 'userId';
  static const String userName = 'userName';
  static const String userLevel = 'userLevel';
  static const String userPhoto = 'userPhoto';
  static const String languageIndex = 'languageIndex';
  static const String countryName = 'countryName';
  static const String deviceLan = 'deviceLan';
  static const String languageValidCode = 'languageValidCode';
  static const String countryValidCode = 'countryValidCode';

  static List<LanguageModel> languages = [
    LanguageModel(languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(languageName: 'German', countryCode: 'DE', languageCode: 'de'),
  ];
}
