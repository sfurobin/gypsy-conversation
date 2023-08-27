import 'dart:convert';
import 'dart:typed_data';
import 'package:chat/helper/remote/exception.dart';
import 'package:chat/utill/api_config.dart';
import 'package:chat/utill/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static const String noInternetMessage = 'Connection lost due to internet connection';
  static const String noResponse = 'Request Timeout';
  final int timeoutInSeconds = 30;

  String? token;
  Map<String, String>? _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(ApiConfig.token);
    if(foundation.kDebugMode) {
      debugPrint('Token: $token');
    }
    updateHeader(token);
  }

  void updateHeader(String? token) {
    Map<String, String> _header = {};
    _header.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    });
    _mainHeaders = _header;
  }

  Future<Response> getData(String uri, {Map<String, dynamic>? query, Map<String, String>? headers}) async {

    if(await ConnectivityService().checkInternetConnectivity()){
      try {
        if(foundation.kDebugMode) {
          debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
        }
        http.Response _response = await http.get(
          Uri.parse(appBaseUrl+uri),
          headers: headers ?? _mainHeaders,
        ).timeout(Duration(seconds: timeoutInSeconds));
        return handleResponse(_response, uri);
      } catch (e) {
        return  const Response(statusCode: 1, statusText: noResponse);
      }
    }else{
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }


  }

  Future<Response> postData(String uri, dynamic body, {Map<String, String>? headers, int? timeout}) async {
    try {
      if(foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body');
      }
      http.Response _response = await http.post(Uri.parse(appBaseUrl+uri), body: jsonEncode(body), headers: headers ?? _mainHeaders,).timeout(Duration(seconds: timeout ?? timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return  const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(String uri, Map<String, String> body, List<MultipartBody> multipartBody, {Map<String, String>? headers}) async {
    try {
      if(foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body with ${multipartBody.length} picture');
      }
      http.MultipartRequest _request = http.MultipartRequest('POST', Uri.parse(appBaseUrl+uri));
      _request.headers.addAll(headers ?? _mainHeaders!);
      for(MultipartBody multipart in multipartBody) {
        if(multipart.file != null) {
          Uint8List _list = await multipart.file!.readAsBytes();
          _request.files.add(http.MultipartFile(
            multipart.key ?? '', multipart.file!.readAsBytes().asStream(), _list.length,
            filename: '${DateTime.now().toString()}.png',
          ));
        }
      }
      _request.fields.addAll(body);
      http.Response _response = await http.Response.fromStream(await _request.send());
      return handleResponse(_response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      if(foundation.kDebugMode) {
        debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
        debugPrint('====> API Body: $body');
      }
      http.Response _response = await http.put(
        Uri.parse(appBaseUrl+uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri, {Map<String, String>? headers}) async {
    try {
      if(foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      http.Response _response = await http.delete(
        Uri.parse(appBaseUrl+uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }





  Response handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    }catch(e) {
      rethrow;
    }
    Response _response = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(headers: response.request!.headers, method: response.request!.method, url: response.request!.url),
      headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
    );
    if(_response.statusCode != 200 && _response.body != null && _response.body is !String) {
      if(_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorClass errorResponse = ErrorClass.fromJson(_response.body);
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: errorResponse.errors![0].message);
      }else if(_response.body.toString().startsWith('message')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
      }
    }else if(_response.statusCode != 200 && _response.body == null) {
      _response = const Response(statusCode: 1005, statusText: noInternetMessage);
    }
    if(foundation.kDebugMode) {
      print('====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
    }
    return _response;
  }
}

class MultipartBody {
  String? key;
  XFile? file;
  MultipartBody(this.key, this.file);
}