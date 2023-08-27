import 'package:chat/utill/color_resources.dart';
import 'package:chat/utill/dimensions.dart';
import 'package:chat/utill/images.dart';
import 'package:chat/utill/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilePage extends StatefulWidget {
  const FilePage({super.key});

  @override
  State<FilePage> createState() => _FilePageState();
}

List<String> _titleList = ["Sister’s webiner.pdf", "Healthyfood.jpg"];
List<String> _subTitleList = ["26.8 KB", "60.8 KB"];
class _FilePageState extends State<FilePage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 2,
        itemBuilder: (_, index){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SvgPicture.asset(AllImages.pdf, width: 32, height: 32,),
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
