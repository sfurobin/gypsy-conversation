import 'package:chat/utill/color_resources.dart';
import 'package:chat/utill/dimensions.dart';
import 'package:chat/utill/styles.dart';
import 'package:chat/view/features/home/controller/home_controller.dart';
import 'package:chat/view/features/message_box/view/inbox_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (home) => Scaffold(
        backgroundColor: ColorResources.getBackgroundColor(context),
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (_, index){
              return InkWell(
                onTap: ()=> Navigator.push(context, CupertinoPageRoute(builder: (_) => const InboxScreen())),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Stack( clipBehavior: Clip.none,
                        children: [
                          ClipOval(
                            child: Image.asset(home.messageList[index].photo ?? '', height: 40, width: 40, fit: BoxFit.cover),
                          ),
                          if(home.messageList[index].isActive!)...[
                            Positioned(
                              bottom: 2, right: -2,
                              child: Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorResources.colorGreen,
                                    border: Border.all(color: ColorResources.colorWhite, width: 1)
                                ),
                              ),
                            )
                          ],
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text(home.messageList[index].name ?? '', style: interMedium.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.fontSizeDefault), overflow: TextOverflow.ellipsis, maxLines: 1)),
                              Text(home.messageList[index].time ?? '', style: interRegular.copyWith(color: ColorResources.colorBlack600, fontSize: Dimensions.fontSizeExtraSmall), overflow: TextOverflow.ellipsis, maxLines: 1),

                            ],
                          ),
                          const SizedBox(height: 2),
                          if(home.messageList[index].seen!)...[
                            Text(home.messageList[index].lastMessage ?? '', style: interRegular.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.fontSizeSmall)),
                          ]else...[
                            Row(
                              children: [
                                Expanded(child: Text(home.messageList[index].lastMessage ?? '', style: interMedium.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.fontSizeSmall), overflow: TextOverflow.ellipsis, maxLines: 1,)),
                                Container(
                                    height: 16,
                                    width: 16,
                                    alignment: Alignment.center,
                                    //padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorResources.colorPrimary,
                                    ),
                                    child: Text(home.messageList[index].count.toString(), style: interMedium.copyWith(color: ColorResources.colorWhite, fontSize: Dimensions.fontSizeOverExtraSmall))),
                              ],
                            ),
                          ]
                        ],
                      )),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
