import 'package:chat/utill/color_resources.dart';
import 'package:chat/utill/dimensions.dart';
import 'package:chat/utill/images.dart';
import 'package:chat/utill/styles.dart';
import 'package:chat/view/features/home/controller/home_controller.dart';
import 'package:chat/view/features/home/data/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {

  final List<MessageModel> _messageList = [
    MessageModel(id: 5011, name: "Google play music", photo: AllImages.musicIcon, lastMessage: 'So, do you want to play music?',time: 'Just now'),
    MessageModel(id: 5012, name: "Gypsy world officials", photo: AllImages.gypsyLogo, lastMessage: 'Gypsy world: Login issues', time: 'Tue'),
    MessageModel(id: 5013, name: "System notification", photo: AllImages.systemMessageIcon,  lastMessage: '', time: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (home) => Scaffold(
        backgroundColor: ColorResources.getBackgroundColor(context),
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            shrinkWrap: true,
            itemCount: _messageList.length,
            itemBuilder: (_, index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.asset(_messageList[index].photo ?? '', height: 40, width: 40, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text(_messageList[index].name ?? '', style: interMedium.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.fontSizeDefault), overflow: TextOverflow.ellipsis, maxLines: 1)),
                            Text(_messageList[index].time ?? '', style: interRegular.copyWith(color: ColorResources.colorBlack600, fontSize: Dimensions.fontSizeExtraSmall), overflow: TextOverflow.ellipsis, maxLines: 1),
                          ],
                        ),
                        const SizedBox(height: 2),

                        if(_messageList[index].lastMessage!.isNotEmpty)...[
                          Text(_messageList[index].lastMessage ?? '', style: interRegular.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.fontSizeSmall)),
                        ]
                      ],
                    )),
                    const SizedBox(width: 16),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
