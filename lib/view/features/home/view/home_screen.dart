import 'package:chat/helper/date_converter.dart';
import 'package:chat/utill/color_resources.dart';
import 'package:chat/utill/dimensions.dart';
import 'package:chat/utill/styles.dart';
import 'package:chat/view/components/custom_appbar.dart';
import 'package:chat/view/features/home/controller/home_controller.dart';
import 'package:chat/view/features/home/view/pages/general_page.dart';
import 'package:chat/view/features/home/view/pages/primary_page.dart';
import 'package:chat/view/features/home/view/pages/request_page.dart';
import 'package:chat/view/features/message_box/view/inbox_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  late ScrollController controller = ScrollController();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    controller = ScrollController();
    Get.find<HomeController>().getMessageList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (home) => Scaffold(
        backgroundColor: ColorResources.getBackgroundColor(context),
        appBar: const CustomAppBar(title: 'Message', isIcon: true),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll) {
                    overScroll.disallowIndicator();
                    return true;
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:home.messageList.map((item) {
                        int index = home.messageList.indexOf(item);
                        return InkWell(
                          onTap: ()=> Navigator.push(context, CupertinoPageRoute(builder: (_) => const InboxScreen())),
                          child: Container(
                            width: 90,
                           // height: 80,
                            alignment: Alignment.center,
                            padding:  EdgeInsets.symmetric(horizontal: index == 0 ? 8.0 : 16),
                            child: Column( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack( clipBehavior: Clip.none,
                                  children: [
                                    ClipOval(
                                      child: Image.asset(item.photo ?? '', height: 48, width: 48, fit: BoxFit.cover),
                                    ),
                                    if(item.isActive!)...[
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
                                const SizedBox(height: 4,),
                                Text(item.name ?? '', style: interRegular.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.fontSizeExtraSmall), overflow: TextOverflow.ellipsis, maxLines: 2, textAlign: TextAlign.center,)
                              ],
                            ),
                          ),
                        );
                      }).toList() ,
                    ),
                  ),
                ),

                const SizedBox(height: Dimensions.paddingSizeSmall),
                SizedBox(
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.passthrough,
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 8, right: 18),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!, width: 2.0),
                          ),
                        ),
                      ),
                      TabBar(
                        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                        splashFactory: NoSplash.splashFactory,
                        isScrollable: true,
                        controller: _tabController,
                        indicator: const UnderlineTabIndicator(
                          borderSide: BorderSide(color: ColorResources.colorPrimary, width: 3.0),
                          insets: EdgeInsets.fromLTRB(8, 0, 8, 0),
                        ),
                        unselectedLabelColor: const Color(0xFF667085),
                        indicatorColor: ColorResources.colorPrimary,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: interMedium.copyWith(color: ColorResources.colorPrimary, fontSize: Dimensions.fontSizeSmall),
                        labelColor: ColorResources.colorPrimary,
                        tabs: [
                          Tab(
                            child: Text("Primary", style: interMedium.copyWith(fontSize: Dimensions.fontSizeSmall),),
                          ),
                          Tab(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text("General", style: interMedium.copyWith(fontSize: Dimensions.fontSizeSmall),),
                            ),
                          ),

                          Tab(
                            child: Row( mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Requests', style: interMedium.copyWith(fontSize: Dimensions.fontSizeSmall),),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFEBF4FF),
                                      borderRadius: BorderRadius.circular(16)
                                  ),
                                  child:  Text('${DateConverter.convertViews('2')}', style: interRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall),),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),


                Expanded(child:  NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll) {
                    overScroll.disallowIndicator();
                    return true;
                  },

                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      PrimaryPage(),
                      GeneralPage(),
                      RequestPage(),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
