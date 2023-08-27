import 'package:chat/data/repository/language_repo.dart';
import 'package:chat/utill/api_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController implements GetxService {
  final LanguageRepo languageRepo;
  final SharedPreferences sharedPreferences;
  LanguageController({required this.languageRepo, required this.sharedPreferences}){
    _getSelectIndex();
    _getDeviceLanguage();
    getCountryName();
  }

  int _selectIndex = 0;
  int get selectIndex => _selectIndex;

  void setSelectIndex(int index) {
    sharedPreferences.setInt(ApiConfig.languageIndex, index);
    _selectIndex = index;
    update();
  }

  int _selectLan = 0;
  int get selectLan => _selectLan;

  void setSelectLan(int index) {
    _selectLan = index;
    update();
  }
  void _getSelectIndex() async {
    _selectIndex = sharedPreferences.getInt(ApiConfig.languageIndex) ?? 0;
  }

  bool _deviceLanguage = true;
  bool get deviceLanguage => _deviceLanguage;

  setDeviceLanguage(bool val){
    sharedPreferences.setBool(ApiConfig.deviceLan, val);
    _deviceLanguage = val;
    update();
  }
  void _getDeviceLanguage() async {
    _deviceLanguage = sharedPreferences.getBool(ApiConfig.deviceLan) ?? true;
  }

  String _selectCountry = '';
  String get selectCountry => _selectCountry;

  void setCountryName (){
    String country = getCountryName();
    if(country.isEmpty) {

      languageRepo.getCountry().then((country) {
       sharedPreferences.setString(ApiConfig.countryName, country);
        _selectCountry = country;
      });


    }else{
      _selectCountry = country;
    }
    update();
  }

  String getCountryName() {
    return sharedPreferences.getString((ApiConfig.countryName)) ?? "";
  }





  final bool  _isLoading = true;
  bool get isLoading => _isLoading;

  List<dynamic> _languages = [];
  List<dynamic> get languages => _languages;

  void searchLanguage(String query, BuildContext context) {
    if (query.isEmpty) {
      _languages.clear();
      _languages = languageRepo.getAllLanguages(context: context);
      update();
    } else {
      _selectIndex = -1;
      _languages = [];
      languageRepo.getAllLanguages(context: context).forEach((product) async {
        if (product.languageName!.toLowerCase().contains(query.toLowerCase())) {
          _languages.add(product);
        }
      });
      update();
    }
  }

  void initializeAllLanguages(BuildContext context) {
    if (_languages.isEmpty) {
      _languages.clear();
      _languages = languageRepo.getAllLanguages(context: context);
    }
  }
}
