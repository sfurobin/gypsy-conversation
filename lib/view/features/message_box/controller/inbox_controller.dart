import 'package:chat/view/features/home/data/model/message_model.dart';
import 'package:chat/view/features/message_box/data/repo/inbox_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InboxController extends GetxController implements GetxService {
  final InboxRepo inboxRepo;
  InboxController({required this.inboxRepo});

  /// for MessageList

  List<MessageModel> _messageList = [];
  List<MessageModel> get messageList => _messageList;

  Future<Response> getMessageList() async{
    Response response = await inboxRepo.getMessageList();
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
