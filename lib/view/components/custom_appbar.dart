import 'package:chat/utill/color_resources.dart';
import 'package:chat/utill/dimensions.dart';
import 'package:chat/utill/images.dart';
import 'package:chat/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist, isIcon;
  final VoidCallback? onBackPressed, onTab;
  final String? actionText, leadingIcon, icon;

  const CustomAppBar({Key? key, this.title, this.isBackButtonExist = true, this.onBackPressed, this.onTab,
    this.icon, this.isIcon = false, this.actionText,this.leadingIcon }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? '', style: interSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.colorBlack)),
      leading: isBackButtonExist ? IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        icon: SvgPicture.asset( leadingIcon ?? AllImages.leftArrow, width: leadingIcon != null ? 14 : 24, height: leadingIcon != null ? 14 : 24,
          // color: Colors.white,
        ),
        onPressed: () => onBackPressed != null ? onBackPressed!() : Get.back(canPop: true),
      ) : const SizedBox(),
      elevation: 0.4,
      centerTitle: true,
      backgroundColor: ColorResources.getBackgroundColor(context),
      actions: [
       if(isIcon)...[
         IconButton(
           splashColor: Colors.transparent,
           highlightColor: Colors.transparent,
           hoverColor: Colors.transparent,
           focusColor: Colors.transparent,
           onPressed: onTab, icon: SvgPicture.asset( icon ?? AllImages.search, width: 24, height: 24),
         )
       ],
        //const SizedBox(width: Dimensions.paddingSizeDefault)
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}
