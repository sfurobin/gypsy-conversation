//
//
// import 'dart:convert';
//
// import 'package:app/helper/remote/exception.dart';
// import 'package:app/utill/api_config.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart' as foundation;
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:get/get_connect/http/src/request/request.dart';
//
//
// class ApiClient extends GetConnect implements GetxService {
//   final String appBaseUrl;
//   final SharedPreferences sharedPreferences;
//   String? token;
//   Map<String, String>? _mainHeaders;
//
//   ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
//     baseUrl = appBaseUrl;
//     timeout = const Duration(seconds: 30);
//     token = sharedPreferences.getString(ApiConfig.token);
//     // debugPrint('Token: $token');
//     _mainHeaders = {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': 'Bearer $token',
//     };
//   }
//
//   void updateHeader(String? token) {
//     _mainHeaders = {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': 'Bearer $token',
//     };
//   }
//
//   Future<Response> setAffiliationData( String roomName,
//       String roomID, String jId, String affiliationType) async {
//     var chatBody = jsonEncode({
//       "name": roomName.toLowerCase() + roomID,
//       "service": "conference.unitedsportshub.com",
//       "jid": jId,
//       "affiliation": affiliationType,
//     });
//
//     final response = await http.post(Uri.parse(ApiConfig.chatGroupAffiliation),
//         headers: {"Content-Type": "application/json"}, body: chatBody);
//
//     debugPrint('---GetX Response>>${response.body}');
//     return Response(statusCode: response.statusCode, body: response.body);
//   }
//
//   Future<Response> sendGroupInviation( String roomName,
//       String roomID, String jId) async {
//     var chatBody = jsonEncode({
//       "name": roomName.toLowerCase() + roomID,
//       "service": "conference.unitedsportshub.com",
//       "password": "",
//       "reason": "Join this Auction Chat Group",
//       "users": jId
//     });
//
//     final response = await http.post(Uri.parse(ApiConfig.sendGroupInvitation),
//         headers: {"Content-Type": "application/json"}, body: chatBody);
//
//     debugPrint('---GetX Response>>${response.body}');
//     return Response(statusCode: response.statusCode, body: response.body);
//   }
//
//   Future<Response> getUserRooms(String jId) async {
//     var chatBody = jsonEncode({
//       "user": jId,
//       "host": ApiConfig.xmppHostName
//     });
//
//     final response = await http.post(Uri.parse(ApiConfig.getUserRooms),
//         headers: {"Content-Type": "application/json"}, body: chatBody);
//
//     debugPrint('---GetX Response>>${response.body}');
//     return Response(statusCode: response.statusCode, body: response.body);
//   }
//
//   Future<Response> resetPassword(
//       int userId, String newPassword) async {
//     var chatBody = jsonEncode({
//       "user": ApiConfig.xmppUserName+userId.toString(),
//       "host": "unitedsportshub.com",
//       "newpass": newPassword
//     });
//
//     final response = await http.post(Uri.parse(ApiConfig.resetPassword),
//         headers: {"Content-Type": "application/json"}, body: chatBody);
//
//     debugPrint('---GetX Response>>${response.body}');
//     return Response(statusCode: response.statusCode, body: response.body);
//   }
//
//   Future<Response> addSharedRosterUser(String name, String group) async {
//     if (name.contains("@")) {
//       name = name.split("@")[0];
//     }
//
//     var chatBody = jsonEncode({
//       "user": name,
//       "host": "unitedsportshub.com",
//       "group": group,
//       "grouphost": "unitedsportshub.com"
//     });
//
//     final response = await http.post(Uri.parse(ApiConfig.sharedUserAdd),
//         headers: {"Content-Type": "application/json"}, body: chatBody);
//
//     debugPrint('---GetX Response>>${response.body}');
//     return Response(statusCode: response.statusCode, body: response.body);
//   }
//
//   Future<Response> destroyRoom(String roomName) async {
//     var chatBody =
//     jsonEncode({"name": roomName, "service": "conference.unitedsportshub.com"});
//
//     final response = await http.post(Uri.parse(ApiConfig.destroyRoom),
//         headers: {"Content-Type": "application/json"}, body: chatBody);
//
//     debugPrint('---GetX Response>>${response.body}');
//     return Response(statusCode: response.statusCode, body: response.body);
//   }
//
//   /// user present
//   Future<Response> userPresent(int id) async {
//     var httpBody = jsonEncode({
//       "user": 'gypsyuser$id',
//       "host": "unitedsportshub.com",
//     });
//     final response = await http.post(Uri.parse(ApiConfig.userPresence),
//         headers: {"Content-Type": "application/json"}, body: httpBody);
//     debugPrint('---GetX Response>>${response.body}');
//     return Response(statusCode: response.statusCode, body: response.body);
//   }
//
//
//   Future<Response> getRoasterList(String id) async {
//     var httpBody = jsonEncode({
//       "user": "gypsyuser$id",
//       "host": "unitedsportshub.com",
//     });
//     final response = await http.post(Uri.parse(ApiConfig.roasterList),
//         headers: {"Content-Type": "application/json"}, body: httpBody);
//     debugPrint('---GetX Response>>${response.body}');
//     return Response(statusCode: response.statusCode, body: response.body);
//   }
//
//
//   /// user Last Online
//   Future<Response> userLastOnline(int id) async {
//     var httpBody = jsonEncode({
//       "user": 'gypsyuser$id',
//       "host": "unitedsportshub.com",
//     });
//     final response = await http.post(Uri.parse(ApiConfig.userLastOnline),
//         headers: {"Content-Type": "application/json"}, body: httpBody);
//     debugPrint('---GetX Response>>${response.body}');
//     return Response(statusCode: response.statusCode, body: response.body);
//   }
//   Future<Response> getVCard(int id) async {
//     var httpBody = jsonEncode({
//       "user": 'gypsyuser$id',
//       "host": "unitedsportshub.com",
//       "name": "URL"
//     });
//     final response = await http.post(Uri.parse(ApiConfig.getVcard), headers: {"Content-Type": "application/json"}, body: httpBody);
//     debugPrint('---GetX Response>>${response.body}');
//     return Response(statusCode: response.statusCode, body: response.body);
//   }
//
//
//   Future<Response> getSpotifySongsList(String token , String query ) async {
//
//     final response = await http.get(Uri.parse("https://api.spotify.com/v1/search?q="+ query + "&type=track&limit=22"),
//         headers: {
//           // "Content-Type": "application/x-www-form-urlencoded",
//           "Authorization": "Bearer $token"
//         }
//     );
//
//     debugPrint('-> token -> $token');
//     debugPrint('---GetX Response>>${response.body}');
//     return Response(statusCode: response.statusCode, body: response.body);
//   }
//
//   Future<Response> getSpotifyAuthToken(String token) async {
//
//     final response = await http.post(Uri.parse(ApiConfig.spotifyTokenURL),
//         headers: {
//           "Content-Type": "application/x-www-form-urlencoded",
//           "Authorization": "Basic OTVkMThjYTQyZWY2NGUzNGI2NmU1MWViNzI4NjYzZGQ6MjhhMjJmOGYwNGMzNDhiMWJmY2E1MjNhOWUzYWEwYjQ="
//         },
//         encoding: Encoding.getByName('utf-8'),
//         body: {"grant_type": "client_credentials"}
//     );
//
//     debugPrint('---GetX Response>>${response.body}');
//     return Response(statusCode: response.statusCode, body: response.body);
//   }
//
//   Future<Response> getData(
//       String uri, {
//         Map<String, dynamic>? query,
//         String? contentType,
//         Map<String, String>? headers,
//         Function(dynamic)? decoder,
//       }) async {
//     try {
//       if (foundation.kDebugMode) {
//         debugPrint('====> GetX Call: $uri');
//       }
//       DateTime time = DateTime.now();
//       var loggerRespRcvTime = time.millisecondsSinceEpoch;
//       Response response = await get(
//         uri,
//         contentType: contentType,
//         query: query,
//         headers: headers ?? _mainHeaders,
//         decoder: decoder,
//       );
//       var link =  baseUrl.toString()  + uri + query.toString();
//       // Get.find<LoggerController>().
//       // saveLog(link, response.statusCode ?? -10  ,response: response.bodyString , isTimeOut: false ,
//       // loggerRespSendTime: loggerRespRcvTime , reqType: "GET" );
//
//
//       response = handleResponse(response);
//
//       if (foundation.kDebugMode) {
//         debugPrint(
//             '====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
//         debugPrint(
//             '====> GetX Response: [${_mainHeaders}] $uri\n${response.body}');
//       }
//       return response;
//     } catch (e) {
//       return Response(statusCode: 1, statusText: e.toString());
//     }
//   }
//
//   Future<Response> httpPost(String uri, dynamic body, {Map<String, String>? headers, int? timeout}) async {
//     try {
//       if(foundation.kDebugMode) {
//         print('====> API Call: $uri\nHeader: $_mainHeaders');
//         print('====> API Body: $body');
//       }
//       http.Response _response = await http.post(
//         Uri.parse(appBaseUrl+uri),
//         body: jsonEncode(body),
//         headers: headers ?? _mainHeaders,
//       ).timeout(Duration(seconds: timeout ?? 30));
//       return httpHandleResponse(_response, uri);
//     } catch (e) {
//       return const Response(statusCode: 1, statusText: 'connection_to_api_server_failed');
//     }
//   }
//
//
//   Future<Response> postData(
//       String uri,
//       dynamic body, {
//         Map<String, dynamic>? query,
//         String? contentType,
//         Map<String, String>? headers,
//         Function(dynamic)? decoder,
//         Function(double)? uploadProgress,
//       }) async {
//     try {
//       if (foundation.kDebugMode) {
//         debugPrint('====> GetX Call: $uri\n');
//         debugPrint('====> GetX Body: $body');
//       }
//
//       DateTime time = DateTime.now();
//       var loggerRespRcvTime = time.millisecondsSinceEpoch;
//       Response response = await post(
//           uri,
//           body,
//           query: query,
//           contentType: contentType,
//           headers: headers ?? _mainHeaders,
//           decoder: decoder,
//           uploadProgress: uploadProgress
//         // uploadProgress: (double percent) {
//         //   // final progress = sent / total;
//         //   // print('progress: $progress ($sent/$total)');
//         //   // // setState(() {
//         //   // progressBar.value = sent / total;
//         //   // test.value = progressBar.value.toString();
//         //   // print('actual uploading :${progressBar.value}');
//         //   // // });
//         //
//         //
//         // },
//       );
//
//       var link =  baseUrl.toString()  + uri + query.toString();
//
//       // Get.find<LoggerController>().
//       // saveLog(link, response.statusCode ?? -10  ,response: response.bodyString , isTimeOut: false ,
//       //     loggerRespSendTime: loggerRespRcvTime , reqType: "GET" );
//
//
//
//       response = handleResponse(response);
//       if (foundation.kDebugMode) {
//         debugPrint(
//             '====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
//       }
//       return response;
//     } catch (e) {
//       return Response(statusCode: 1, statusText: e.toString());
//     }
//   }
//
//   Future<Response> putData(
//       String uri,
//       dynamic body, {
//         Map<String, dynamic>? query,
//         String? contentType,
//         Map<String, String>? headers,
//         Function(dynamic)? decoder,
//         Function(double)? uploadProgress,
//       }) async {
//     try {
//       if (foundation.kDebugMode) {
//         // debugPrint('====> GetX Call: $uri\nToken: $token');
//         debugPrint('====> GetX Body: $body');
//       }
//       Response response = await put(
//         uri,
//         body,
//         query: query,
//         contentType: contentType,
//         headers: headers ?? _mainHeaders,
//         decoder: decoder,
//         uploadProgress: uploadProgress,
//       );
//       response = handleResponse(response);
//       if (foundation.kDebugMode) {
//         debugPrint(
//             '====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
//       }
//       return response;
//     } catch (e) {
//       return Response(statusCode: 1, statusText: e.toString());
//     }
//   }
//
//   Future<Response> deleteData(
//       String uri, {
//         Map<String, dynamic>? query,
//         String? contentType,
//         Map<String, String>? headers,
//         Function(dynamic)? decoder,
//       }) async {
//     try {
//       if (foundation.kDebugMode) {
//         // debugPrint('====> GetX Call: $uri\nToken: $token');
//       }
//       Response response = await delete(
//         uri,
//         headers: headers ?? _mainHeaders,
//         contentType: contentType,
//         query: query,
//         decoder: decoder,
//       );
//       response = handleResponse(response);
//       if (foundation.kDebugMode) {
//         debugPrint('====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
//       }
//       return response;
//     } catch (e) {
//       return Response(statusCode: 1, statusText: e.toString());
//     }
//   }
//
//   Response handleResponse(Response response) {
//     Response _response = response;
//     if (_response.hasError &&
//         _response.body != null &&
//         _response.body is! String) {
//       if (_response.body.toString().startsWith('{errors: [{code:')) {
//         ErrorClass _errorResponse = ErrorClass.fromJson(_response.body);
//         _response = Response(
//             statusCode: _response.statusCode,
//             body: _response.body,
//             statusText: _errorResponse.errors![0].message);
//       } else if (_response.body.toString().startsWith('{message')) {
//         _response = Response(
//             statusCode: _response.statusCode,
//             body: _response.body,
//             statusText: _response.body['message']);
//       }
//     } else if (_response.hasError && _response.body == null) {
//       _response = const Response(
//           statusCode: 1005,
//           statusText: 'Connection lost due to internet connection');
//     }
//     return _response;
//   }
//
//   Response httpHandleResponse(http.Response response, String uri) {
//     dynamic _body;
//     try {
//       _body = jsonDecode(response.body);
//     }catch(e) {
//       rethrow;
//     }
//     Response _response = Response(
//       body: _body ?? response.body, bodyString: response.body.toString(),
//       request: Request(headers: response.request!.headers, method: response.request!.method, url: response.request!.url),
//       headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
//     );
//     if(_response.statusCode != 200 && _response.body != null && _response.body is !String) {
//       if(_response.body.toString().startsWith('{errors: [{code:')) {
//         ErrorClass _errorResponse = ErrorClass.fromJson(_response.body);
//         _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.errors![0].message);
//       }else if(_response.body.toString().startsWith('{message')) {
//         _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
//       }
//     }else if(_response.statusCode != 200 && _response.body == null) {
//       _response = const Response(statusCode: 1005, statusText: 'connection_to_api_server_failed');
//     }
//     if(foundation.kDebugMode) {
//       print('====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
//     }
//     return _response;
//   }
//
// }
