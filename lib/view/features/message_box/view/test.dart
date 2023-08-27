import 'package:chat/utill/color_resources.dart';
import 'package:chat/utill/dimensions.dart';
import 'package:chat/utill/images.dart';
import 'package:chat/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatModel{
  final String _messages;
  final bool _isMe;
  ChatModel(this._messages, this._isMe);

  String get message => _messages;
  bool get isMee => _isMe;
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final List<ChatModel> _chatList = [];
  var controller = TextEditingController();
  var scrollController = ScrollController();
  var message = '';

  void animateList() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    Future.delayed(const Duration(milliseconds: 400), (){
      if(scrollController.offset != scrollController.position.maxScrollExtent) {
        animateList();
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('chat'.tr, style: interRegular.copyWith(fontSize: 22,
              color: ColorResources.getWhiteColor(context),
            )),

          ],
        ),
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          icon: const Icon(Icons.arrow_back, color: ColorResources.colorGreen, size: 20,),
          onPressed: () => Get.back(canPop: true),
        ),
        elevation: 1,
        centerTitle: false,
        backgroundColor: ColorResources.colorPrimary,
        shadowColor: ColorResources.colorBlack.withOpacity(0.12),
        bottomOpacity: 0.3,
        automaticallyImplyLeading: false,
        titleSpacing: 10,
      ),
      backgroundColor: ColorResources.getGreyColor(context),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.grey
        ),
        child: Column(
          children: [
            Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: ListView.builder(
                  reverse:  true,
                    controller: scrollController,
                    padding: const EdgeInsets.only(bottom: 10),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _chatList.length,
                    itemBuilder: (context, index) {
                      return  _chatList.elementAt(index).isMee
                          ? _sender(_chatList.elementAt(index).message)
                          : _receiver(_chatList.elementAt(index).message);
                    }
                )),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFieldBubble(
                        clipper: TextFieldClipper(alignment: Alignment.bottomRight),
                        backGroundColor: ColorResources.getBackgroundColor(context),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextFormField(
                                maxLines: 4,
                                minLines: 1,
                                keyboardType: TextInputType.multiline,
                                controller: controller,
                                onFieldSubmitted: (value) {
                                  controller.text = value;
                                },
                                onChanged: (v){
                                  setState(() {
                                    v = controller.text;
                                  });
                                },
                                style: interRegular.copyWith(color: ColorResources.getTextColor(context)),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 0, right: 12),
                                  border: InputBorder.none,
                                  focusColor: Colors.white,
                                  hintText: 'send_message'.tr,
                                  hintStyle: interRegular.copyWith(color: ColorResources.getGreyColor(context)),
                                ),
                              ),
                            ),
                            const SizedBox(width: Dimensions.mediumSmallSizeFont),
                            Padding(
                                padding:  EdgeInsets.only(bottom: 12, left: 16, right: 0),
                                child: InkWell(onTap: (){},
                                    child: SvgPicture.asset(AllImages.attach, height: 24,width: 24,))
                            ),

                          ],
                        )
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall,),
                  GestureDetector(
                    onTap: controller.text.isEmpty ? null : () {
                      if(controller.text.isNotEmpty){
                        setState(() {
                          _chatList.add(ChatModel(controller.text, true));
                          animateList();
                          controller.clear();
                        });
                      }else{
                        //showSnackBar('write_something'.tr);
                      }

                    },
                    onLongPress: controller.text.isEmpty ? null : () {
                      if(controller.text.isNotEmpty){
                        setState(() {
                          _chatList.add(ChatModel(controller.text, false));
                          animateList();
                          controller.clear();
                        });
                      }else{
                        //showSnackBar('write_something'.tr);
                      }

                    },
                    child: SvgPicture.asset(AllImages.send, height: 48,width: 48,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _sender(String text){
    return ChatBubble(
      clipper: ChatBubbleClipper2(alignment: Alignment.bottomRight),
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: 20),
      padding:  EdgeInsets.fromLTRB(22, 8, 10,8),
      backGroundColor: ColorResources.colorGreen,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Text(
          text,
          style: interRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getTextColor(context),),
        ),

        // RichText(
        //   text: TextSpan(
        //     text: text,
        //     style: DefaultTextStyle.of(context).style.merge(robotoRegular.copyWith(fontSize: MySizes.fontSizeLarge, color: MyColor.getTextColor())),
        //     // children: <TextSpan>[
        //     //   TextSpan(text: ' ${DateFormat('H:mm a').format(DateTime.now())}',
        //     //     style: Theme.of(context).textTheme.bodySmall?.merge(
        //     //         robotoLight.copyWith(
        //     //             fontSize: MySizes.fontSizeDefault,
        //     //             color: MyColor.getGreyColor()
        //     //         )
        //     //     ),
        //     //   ),
        //     // ],
        //   ),
        // ),
      ),
    );
  }

  Widget _receiver(String text){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: ColorResources.getWhiteColor(context),
          child: Image.asset(AllImages.profile1, height: 15, width: 15, fit: BoxFit.cover,),
        ),
        ChatBubble(
          clipper: ChatBubbleClipper2(alignment:  Alignment.bottomRight),
          backGroundColor:ColorResources.getBackgroundColor(context),
          margin: const EdgeInsets.only(top: 20),
          padding:  EdgeInsets.fromLTRB(10,8, 22,8),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: RichText(
              text: TextSpan(
                text: text,
                style: interRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getTextColor(context),),
                // children: <TextSpan>[
                //   TextSpan(text: ' ${DateFormat('H:mm a').format(DateTime.now())}',
                //     style: Theme.of(context).textTheme.bodySmall?.merge(
                //         robotoLight.copyWith(
                //             fontSize: MySizes.fontSizeDefault,
                //             color: MyColor.getGreyColor()
                //         )
                //     ),
                //   ),
                // ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


/// for edit field
class TextFieldClipper extends CustomClipper<Path> {
  final Alignment? alignment;
  final double radius;
  final double nipHeight;
  final double nipWidth;
  final double nipRadius;

  TextFieldClipper(
      {this.alignment,
        this.radius = 10,
        this.nipHeight = 10,
        this.nipWidth = 10,
        this.nipRadius = 1});

  @override
  Path getClip(Size size) {
    var path = Path();

    if (alignment == Alignment.bottomLeft) {
      path.lineTo(size.width - radius - nipWidth, 0);
      path.arcToPoint(Offset(size.width - nipWidth, radius),
          radius: Radius.circular(radius));
      path.lineTo(size.width - nipWidth, size.height - nipHeight);
      path.lineTo(size.width - nipRadius, size.height - nipRadius);
      path.arcToPoint(Offset(size.width - nipRadius, size.height),
          radius: Radius.circular(nipRadius));
      path.lineTo(radius, size.height);
      path.arcToPoint(Offset(0, size.height - radius),
          radius: Radius.circular(radius));
      path.lineTo(0, radius);
      path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
    } else {
      path.lineTo(size.width - radius, 0);
      path.arcToPoint(Offset(size.width, radius),
          radius: Radius.circular(radius));
      path.lineTo(size.width, size.height - radius);
      path.arcToPoint(Offset(size.width - radius, size.height),
          radius: Radius.circular(radius));
      path.lineTo(nipRadius, size.height);
      path.arcToPoint(Offset(nipRadius, size.height - nipRadius),
          radius: Radius.circular(nipRadius));
      path.lineTo(nipWidth, size.height - nipHeight);
      path.lineTo(nipWidth, radius);
      path.arcToPoint(Offset(radius + nipWidth, 0),
          radius: Radius.circular(radius));
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
class TextFieldBubble extends StatelessWidget {
  final CustomClipper? clipper;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final Color? backGroundColor;
  final Color? shadowColor;
  final Alignment? alignment;
  final EdgeInsetsGeometry? padding;

  const TextFieldBubble(
      {super.key, this.clipper,
        this.child,
        this.margin,
        this.elevation,
        this.backGroundColor,
        this.shadowColor,
        this.alignment,
        this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: PhysicalShape(
        clipper: clipper as CustomClipper<Path>,
        elevation: elevation ?? 2,
        color: backGroundColor ?? ColorResources.colorPrimary,
        shadowColor: shadowColor ?? Colors.transparent,
        child: child ?? Container(),
      ),
    );
  }
}









/// for chat bubble
class ChatBubbleClipper2 extends CustomClipper<Path> {
  final Alignment? alignment;
  final double radius;
  final double nipHeight;
  final double nipWidth;
  final double nipRadius;

  ChatBubbleClipper2(
      {this.alignment,
        this.radius = 10,
        this.nipHeight = 10,
        this.nipWidth = 15,
        this.nipRadius =1});

  @override
  Path getClip(Size size) {
    var path = Path();

    if (alignment == Alignment.bottomLeft) {
      path.lineTo(size.width - radius - nipWidth, 0);
      path.arcToPoint(Offset(size.width - nipWidth, radius),
          radius: Radius.circular(radius));
      path.lineTo(size.width - nipWidth, size.height - nipHeight);
      path.lineTo(size.width - nipRadius, size.height - nipRadius);
      path.arcToPoint(Offset(size.width - nipRadius, size.height),
          radius: Radius.circular(nipRadius));
      path.lineTo(radius, size.height);
      path.arcToPoint(Offset(0, size.height - radius),
          radius: Radius.circular(radius));
      path.lineTo(0, radius);
      path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
    } else {
      path.lineTo(size.width - radius, 0);
      path.arcToPoint(Offset(size.width, radius),
          radius: Radius.circular(radius));
      path.lineTo(size.width, size.height - radius);
      path.arcToPoint(Offset(size.width - radius, size.height),
          radius: Radius.circular(radius));
      path.lineTo(nipRadius, size.height);
      path.arcToPoint(Offset(nipRadius, size.height - nipRadius),
          radius: Radius.circular(nipRadius));
      path.lineTo(nipWidth, size.height - nipHeight);
      path.lineTo(nipWidth, radius);
      path.arcToPoint(Offset(radius + nipWidth, 0),
          radius: Radius.circular(radius));
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}



class ChatBubble extends StatelessWidget {
  final CustomClipper? clipper;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final Color? backGroundColor;
  final Color? shadowColor;
  final Alignment? alignment;
  final EdgeInsetsGeometry? padding;

  const ChatBubble(
      {super.key, this.clipper,
        this.child,
        this.margin,
        this.elevation,
        this.backGroundColor,
        this.shadowColor,
        this.alignment,
        this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? Alignment.topLeft,
      margin: margin ?? const EdgeInsets.all(0),
      child: PhysicalShape(
        clipper: clipper as CustomClipper<Path>,
        elevation: elevation ?? 2,
        color: backGroundColor ?? ColorResources.colorPrimary,
        shadowColor: shadowColor ?? Colors.transparent,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(12),
          child: child ?? Container(),
        ),
      ),
    );
  }
}



