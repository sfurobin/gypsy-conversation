
import 'package:chat/utill/color_resources.dart';
import 'package:chat/utill/dimensions.dart';
import 'package:chat/utill/images.dart';
import 'package:chat/utill/styles.dart';
import 'package:chat/view/components/common_dialog.dart';
import 'package:chat/view/features/user_details/controller/user_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ThreeDotBottomSheet extends StatelessWidget {
  const ThreeDotBottomSheet({super.key});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserDetailsController>(
      builder: (userDetails) => Container(
        decoration: const BoxDecoration(
            color: ColorResources.colorWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8))
        ),
        child: Column( mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8,),
            Row( mainAxisAlignment : MainAxisAlignment.center,
              children: [
                Container(
                  height: 3,width: 40,
                  color: const Color(0xFF667085),
                )
              ],),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Wrap(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: (){
                            Get.back();
                            if(Get.isDialogOpen!){
                              Get.back();
                            }

                            showGeneralDialog(
                                barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                transitionBuilder: (context, a1, a2, widget) {
                                  return Transform.scale(
                                    scale: a1.value,
                                    child: Opacity(
                                        opacity: a1.value,
                                        child: CommonDialog(
                                          onYes: "Confirm",
                                          title: Align(alignment: Alignment.topRight, child: InkWell(onTap: ()=> Get.back(),child: SvgPicture.asset(AllImages.close, height: 24, width: 24, color: ColorResources.subtextColor,))),
                                          content: Column( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Align(alignment: Alignment.topLeft,child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Text('Report user', style: interBold.copyWith(color: ColorResources.colorBlack, fontSize: Dimensions.fontSizeLarge),),
                                              )),
                                              SizedBox(height: Dimensions.fontSizeExtraSmall),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: RichText(text: TextSpan(
                                                  text: "Are you sure you want to report this user?",
                                                  style: interRegular.copyWith(color: const Color(0xFF475467), fontSize: Dimensions.fontSizeDefault),
                                                  /* children: [
                                                      TextSpan(text: 'Phoenix Baker?',  style: interSemiBold.copyWith(color:  ColorResources.subtextColor, fontSize: Dimensions.fontSizeDefault)),
                                                    ]*/
                                                )),
                                              ),
                                            ],
                                          ),
                                          onTab: () => Get.back(),)
                                    ),
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 200),
                                barrierDismissible: false,
                                context: context,
                                pageBuilder: (context, animation1, animation2) {
                                  return const SizedBox();
                                });


                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("Report", style: interRegular.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.fontSizeDefault), textAlign: TextAlign.center),
                          )),
                    ),
                    const SizedBox(height: 50,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: (){
                            Get.back();
                            if(Get.isDialogOpen!){
                              Get.back();
                            }
                            showGeneralDialog(
                                barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                transitionBuilder: (context, a1, a2, widget) {
                                  return Transform.scale(
                                    scale: a1.value,
                                    child: Opacity(
                                        opacity: a1.value,
                                        child: CommonDialog(
                                          onYes: 'Block user',
                                          title: Align(alignment: Alignment.topRight, child: InkWell(onTap: ()=> Get.back(),child: SvgPicture.asset(AllImages.close, height: 24, width: 24, color: ColorResources.subtextColor,))),
                                          content: Column( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Align(alignment: Alignment.topLeft,child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Text('Block users', style: interBold.copyWith(color: ColorResources.colorBlack, fontSize: Dimensions.fontSizeLarge),),
                                              )),
                                              SizedBox(height: Dimensions.fontSizeExtraSmall),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: RichText(text: TextSpan(
                                                    text: "Are you sure you want to block ",
                                                    style: interRegular.copyWith(color: const Color(0xFF475467), fontSize: Dimensions.fontSizeDefault),
                                                    children: [
                                                      TextSpan(text: 'Phoenix Baker?',  style: interSemiBold.copyWith(color:  ColorResources.subtextColor, fontSize: Dimensions.fontSizeDefault)),
                                                    ]
                                                )),
                                              ),
                                            ],
                                          ),
                                          onTab: () => Get.back(),)
                                    ),
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 200),
                                barrierDismissible: false,
                                context: context,
                                pageBuilder: (context, animation1, animation2) {
                                  return const SizedBox();
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text( 'Block user', style: interRegular.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.fontSizeDefault), textAlign: TextAlign.center),
                          )),
                    ),
                    const SizedBox(height: 50,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () {
                            Get.back();
                            showGeneralDialog(
                                barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                transitionBuilder: (context, a1, a2, widget) {
                                  return Transform.scale(
                                    scale: a1.value,
                                    child: Opacity(
                                        opacity: a1.value,
                                        child: CommonDialog(
                                          onYes: "Delete",
                                          title: Align(alignment: Alignment.topRight, child: InkWell(onTap: ()=> Get.back(),child: SvgPicture.asset(AllImages.close, height: 24, width: 24, color: ColorResources.subtextColor,))),
                                          content: Column( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Align(alignment: Alignment.topLeft,child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Text('Delete contact', style: interBold.copyWith(color: ColorResources.colorBlack, fontSize: Dimensions.fontSizeLarge),),
                                              )),
                                              SizedBox(height: Dimensions.fontSizeExtraSmall),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: RichText(text: TextSpan(
                                                    text: "Are you sure you want to delete this contact?",
                                                    style: interRegular.copyWith(color: const Color(0xFF475467), fontSize: Dimensions.fontSizeDefault),
                                                   /* children: [
                                                      TextSpan(text: 'Phoenix Baker?',  style: interSemiBold.copyWith(color:  ColorResources.subtextColor, fontSize: Dimensions.fontSizeDefault)),
                                                    ]*/
                                                )),
                                              ),
                                            ],
                                          ),
                                          onTab: () => Get.back(),)
                                    ),
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 200),
                                barrierDismissible: false,
                                context: context,
                                pageBuilder: (context, animation1, animation2) {
                                  return const SizedBox();
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('Delete Conversation', style: interRegular.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.fontSizeDefault), textAlign: TextAlign.center),
                          )),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
