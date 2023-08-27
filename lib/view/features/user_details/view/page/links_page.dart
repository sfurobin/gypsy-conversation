import 'package:chat/utill/color_resources.dart';
import 'package:chat/utill/dimensions.dart';
import 'package:chat/utill/images.dart';
import 'package:chat/utill/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LinksPage extends StatefulWidget {
  const LinksPage({super.key});

  @override
  State<LinksPage> createState() => _LinksPageState();
}

List<String> _titleList = ["Google Meet", "Figma"];
List<String> _subTitleList = ["Real-time meetings by Google. Using your browser, share your video, desktop, and presentations with teammates and https://meet.google.com/skb-mjs-ary", "https://www.figma.co…iOxQ1JyzEDq5R3F-4"];
List<String> _iconList = [AllImages.gMeet, AllImages.figmaIcon];

class _LinksPageState extends State<LinksPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 2,
        itemBuilder: (_, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row( crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(_iconList[index], width: 32, height: 32,),
                const SizedBox(width: 8),
                Expanded(
                  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_titleList[index], style: interMedium.copyWith(color: ColorResources.getTextColor(context) , fontSize: Dimensions.fontSizeSmall)),
                      const SizedBox(height: 2),
                      Text(_subTitleList[index], style: interRegular.copyWith(color: ColorResources.colorBlack , fontSize: Dimensions.fontSizeExtraSmall)),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
