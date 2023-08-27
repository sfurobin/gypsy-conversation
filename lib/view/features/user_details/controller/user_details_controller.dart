import 'package:chat/view/features/home/data/model/message_model.dart';
import 'package:chat/view/features/user_details/data/repo/user_details_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailsController extends GetxController implements GetxService {
  final UserDetailsRepo userDetailsRepo;
  UserDetailsController({required this.userDetailsRepo});

 bool _isMute = false;
 bool get isMute => _isMute;

 setMute(bool val){
   _isMute  = val;
   update();
 }

}
