import 'package:chat/data/response/language_model.dart';
import 'package:chat/utill/api_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext? context}) {
    return ApiConfig.languages;
  }

  Future<String> getCountry() async {
    final response = await http.get(Uri.parse('http://ip-api.com/json'));

    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      final countryName = parsedResponse['country'];
      return countryName;
    } else {
      throw Exception('Failed to load location info');
    }
  }

}

