

import 'package:chat/utill/color_resources.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final double height;
  final double weight;
  final bool isColor;
  const ProfileAvatar({Key? key, required this.imageUrl, this.height = 32, this.weight=32, this.isColor = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: weight,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isColor ? ColorResources.colorBlack.withOpacity(0.1) : null
      ),
      child: ClipOval(child: Image.asset(
        imageUrl ?? '',
        height: 92,
        width: 92,
        fit: BoxFit.cover,
      )
      ),
    );
  }
}