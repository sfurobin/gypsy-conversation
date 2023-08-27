import 'package:chat/utill/color_resources.dart';
import 'package:chat/utill/dimensions.dart';
import 'package:chat/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final String? onYes;
  final String? onNo;
  final VoidCallback onTab;
  final bool isLoading;
  const CommonDialog({Key? key, required this.title, this.content, this.onYes, this.onNo, required this.onTab, this.isLoading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),

      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color:const Color(0xFFD0D5DD)),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Text(
                      onNo ?? 'Cancel',
                      style: interSemiBold.copyWith(color: ColorResources.colorBlack, fontSize: Dimensions.fontSizeDefault),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: onTab,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        color: const Color(0xFFD92D20),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Text(
                      onYes ?? 'Unfollow',
                      style: interSemiBold.copyWith(color: ColorResources.colorWhite, fontSize: Dimensions.fontSizeDefault),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        )
      ],
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
      title: title,
      content: content,
    );
  }
}