

import 'package:chat/utill/color_resources.dart';
import 'package:chat/utill/images.dart';
import 'package:flutter/material.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({Key? key}) : super(key: key);

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {

  final List<String> _imageList = [
    AllImages.profile1,
    AllImages.profile2,
    AllImages.profile3,
    AllImages.profile4,
    AllImages.profile5,
  ];

  @override
  Widget build(BuildContext context) {
    return  NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowIndicator();
        return true;
      },
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 130,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1
          ),
          itemCount: _imageList.length,
          padding: const EdgeInsets.only(bottom: 20),
          itemBuilder: (_, index){
            if(index % 2 == 0){
              return InkWell(
                child: Stack( alignment: Alignment.center,
                  children: [
                    Image.asset(_imageList[index], height: double.infinity, width: double.infinity, fit: BoxFit.cover,),
                    Positioned(child: Container(
                      height: 30, width: 30,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                      ),
                      child: const Icon(Icons.play_arrow, color: ColorResources.colorPrimary,),
                    ))
                  ],
                ),
              );
            }
            return InkWell(
              child: Image.asset(_imageList[index], height: double.infinity, width: double.infinity, fit: BoxFit.cover,),
            );
          }),
    );
  }
}
