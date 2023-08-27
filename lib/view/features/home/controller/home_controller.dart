import 'package:chat/view/features/home/data/model/message_model.dart';
import 'package:chat/view/features/home/data/repo/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController implements GetxService {
  final HomeRepo homeRepo;
  HomeController({required this.homeRepo});

  /// for MessageList

  List<MessageModel> _messageList = [];
  List<MessageModel> get messageList => _messageList;

  Future<Response> getMessageList() async{
    Response response = await homeRepo.getMessageList();
    if(response.statusCode == 200){
      _messageList =[];
      _messageList.addAll(response.body);
    }else{
      debugPrint("Nothing to found");
    }
    update();
    return response;
  }


}
