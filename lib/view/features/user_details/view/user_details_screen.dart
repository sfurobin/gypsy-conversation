import 'package:chat/utill/color_resources.dart';
import 'package:chat/utill/dimensions.dart';
import 'package:chat/utill/images.dart';
import 'package:chat/utill/styles.dart';
import 'package:chat/view/components/custom_appbar.dart';
import 'package:chat/view/components/profile_avatar.dart';
import 'package:chat/view/features/user_details/controller/user_details_controller.dart';
import 'package:chat/view/features/user_details/view/page/file_page.dart';
import 'package:chat/view/features/user_details/view/page/links_page.dart';
import 'package:chat/view/features/user_details/view/page/media_page.dart';
import 'package:chat/view/features/user_details/view/widget/three_dot_bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  final list = ["Media", "File", "Links"];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getBackgroundColor(context),
      appBar: CustomAppBar(isIcon: true, icon: AllImages.threeVerticalDot, onTab: (){
        Get.bottomSheet(const ThreeDotBottomSheet());
      },),
      body: SafeArea(
        child: Column(
          children: [
           Padding(
             padding: const EdgeInsets.all(16),
             child: Column(
               children: [
                 Row(
                   children: [
                     Stack( clipBehavior: Clip.none,
                       children: [
                         const ProfileAvatar(imageUrl: AllImages.profile1, height: 48, weight: 48,),
                         Positioned(
                           bottom: -1, right: -1,
                           child: Container(
                             height: 10,
                             width: 10,
                             decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: ColorResources.colorGreen,
                                 border: Border.all(color: ColorResources.colorWhite, width: 1.5)
                             ),
                           ),
                         )
                       ],
                     ),
                     const SizedBox(width: 8),
                     Column( crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('Kabir', style: interSemiBold.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.fontSizeSmall),),
                         Text('Last seen recently', style: interRegular.copyWith(color: ColorResources.colorBlack600, fontSize: Dimensions.fontSizeExtraSmall),),
                       ],
                     )

                   ],
                 ),

                 const Divider(color: ColorResources.dividerColor,),

                 _muteMessage(),

                 const Divider(color: ColorResources.dividerColor,),

                 SizedBox(
                   width: double.infinity,
                   child: Stack(
                     fit: StackFit.passthrough,
                     alignment: Alignment.bottomCenter,
                     children: <Widget>[
                       Container(
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
                           borderSide: BorderSide(color: ColorResources.colorPrimary, width: 2.0),
                           insets: EdgeInsets.fromLTRB(0, 0, 0, 0),
                         ),
                         unselectedLabelColor: const Color(0xFF667085),
                         indicatorColor: ColorResources.colorPrimary,
                         indicatorSize: TabBarIndicatorSize.tab,
                         labelStyle: interMedium.copyWith(color: ColorResources.colorPrimary, fontSize: Dimensions.fontSizeSmall),
                         labelColor: ColorResources.colorPrimary,
                         tabs: list.map((item){
                           return Tab(text: item,);
                         }).toList(),
                       ),
                     ],
                   ),
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
                  MediaPage(),
                  FilePage(),
                  LinksPage(),
                ],
              ),
            ))



          ],
        ),
      ),
    );
  }

  Widget _muteMessage(){
    return GetBuilder<UserDetailsController>(
      builder: (userDetails)=> Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column( crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Notifications', style: interRegular.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.fontSizeSmall)),
                Text('Off', style: interRegular.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.fontSizeExtraSmall)),
              ],
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              if(userDetails.isMute){
                userDetails.setMute(false);
              }else{
                userDetails.setMute(true);
               // Get.dialog(const MuteAlertDialog());
              }
            },
            child:
            userDetails.isMute ? Container(
              width: 40,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorResources.colorPrimary,
              ),
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Container(
                    height: 24,
                    width: 24,
                    margin: const EdgeInsets.fromLTRB(0, 1,0,1),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResources.colorWhite,
                        boxShadow: [BoxShadow(color: ColorResources.getGreyColor(context), blurRadius: 0.5, spreadRadius: 0.2 )]
                    ),
                  )
                ],
              ),
            ) : Container(
              width: 40,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade300,
              ),
              child: Row(
                children: [
                  Container(
                    height: 24,
                    width: 24,
                    margin: const EdgeInsets.fromLTRB(0, 1,1,1),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResources.colorWhite,
                        boxShadow: [BoxShadow(color: ColorResources.getGreyColor(context), blurRadius: 0.5, spreadRadius: 0.2)]
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


