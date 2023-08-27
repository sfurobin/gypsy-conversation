import 'package:chat/utill/images.dart';
import 'package:chat/view/features/home/data/model/message_model.dart';
import 'package:get/get.dart';

class InboxRepo {
  Future<Response> getMessageList () async {
    try{
      List<MessageModel> messageList = [
        MessageModel(id: 5001, name: "Adam Steve", photo: AllImages.profile1, isActive: true, lastMessage: 'Hi', message: "Hi, this is kabir from Mirpur", time: 'Just now', seen: false, count: 2),
        MessageModel(id: 5002, name: "Darlene Robertson", photo: AllImages.profile2, isActive: true, lastMessage: 'Hi, Whats Up?', message: "Hi, this is kabir from Mirpur", time: '19:31 PM', seen: false, count: 2),
        MessageModel(id: 5003, name: "Cameron William", photo: AllImages.profile3, isActive: false, lastMessage: 'Ok, fine', message: "Hi, this is kabir from Mirpur", time: 'Tue', seen: true, count: 2),
        MessageModel(id: 5004, name: "Guy Hawkins", photo: AllImages.profile4, isActive: true, lastMessage: 'See you tomorrow', message: "Hi, this is kabir from Mirpur", time: 'Jul 7', seen: true, count: 8),
        MessageModel(id: 5005, name: "Ava Wrights", photo: AllImages.profile5, isActive: false, lastMessage: 'Nice to meet you', message: "Hi, this is kabir from Mirpur", time: 'Aug 13, 2022', seen: true, count: 4),
      ];

      Response response = Response(body: messageList, statusCode: 200);
      return response;
    }catch (e) {
      return const Response( statusCode:404,statusText: "Data not found");
    }
  }

}

