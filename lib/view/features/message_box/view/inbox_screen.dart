import 'package:chat/utill/color_resources.dart';
import 'package:chat/utill/dimensions.dart';
import 'package:chat/utill/images.dart';
import 'package:chat/utill/styles.dart';
import 'package:chat/view/components/profile_avatar.dart';
import 'package:chat/view/features/home/data/model/message_model.dart';
import 'package:chat/view/features/user_details/view/user_details_screen.dart';
import 'package:chat/view/features/user_details/view/widget/three_dot_bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {

  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageNode = FocusNode();
  ScrollController scrollController = ScrollController();
  var message = '';

  bool _isActive = false;
  final List<MessageModel> _messageList = [];

  void animateList() {
   if(scrollController.hasClients){
     scrollController.jumpTo(scrollController.position.maxScrollExtent);
     Future.delayed(const Duration(milliseconds: 400), (){
       if(scrollController.offset != scrollController.position.maxScrollExtent) {
         animateList();
       }
     });
   }
  }
  @override
  void initState() {
    // TODO: implement initState

    scrollController.addListener(() {
      setState(() {
        _isActive = scrollController.offset > 400 ? true : false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getBackgroundColor(context),
      appBar: AppBar(
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          icon: SvgPicture.asset(AllImages.leftArrow, width: 24, height: 24,
            // color: Colors.white,
          ),
          onPressed: () => Get.back(canPop: true),
        ),
        elevation: 0.4,
        centerTitle: true,
        backgroundColor: ColorResources.getBackgroundColor(context),
        title: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: ()=> Navigator.push(context, CupertinoPageRoute(builder: (_) => const UserDetailsScreen())),
          child: Row(
            children: [
              Stack( clipBehavior: Clip.none,
                children: [
                  const ProfileAvatar(imageUrl: AllImages.profile1),
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
                 Text('Online', style: interRegular.copyWith(color: ColorResources.colorBlack600, fontSize: Dimensions.fontSizeExtraSmall),),
               ],
             )

            ],
          ),
        ),
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            icon: SvgPicture.asset(AllImages.threeVerticalDot, width: 24, height: 24,
            ),
            onPressed: () {
                Get.bottomSheet(const ThreeDotBottomSheet()).then((value) {
                  setState(() {
                    _messageNode.unfocus();
                    _messageNode.canRequestFocus = false;
                  });
                });
                },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if(_messageList.isNotEmpty)...[
              Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      padding: const EdgeInsets.only(bottom: 10),
                      physics: const BouncingScrollPhysics(),
                      itemCount: _messageList.length,
                      itemBuilder: (context, index) {
                        return  _messageList.elementAt(index).isMe!
                            ? _sender(_messageList.elementAt(index).message!)
                            : _receiver(_messageList.elementAt(index).message!);
                      }
                  )),
            ]else...[
              Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.end, mainAxisSize: MainAxisSize.min,
                children: const [
                  Divider(),
                  SizedBox(height: 25),
                  Text('No messages here yet.\nSend message to start conversation',
                    textAlign: TextAlign.center),
                  SizedBox(height: 25),
                ],
              )),
            ],


            Container(
              padding: const EdgeInsets.fromLTRB(16,4,0,4),
              decoration: const BoxDecoration(
                color: ColorResources.colorGrey100
              ),
              child: CupertinoTextField(
                prefix: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SvgPicture.asset(AllImages.emoji, width: 24, height: 24,),
                  ),
                ),
                suffix: InkWell(
                  onTap: _messageController.text.isEmpty ? null : () {
                    if(_messageController.text.isNotEmpty){
                      setState(() {
                        _messageList.add(MessageModel(message: _messageController.text, isMe: true));
                        animateList();
                        _messageController.clear();
                      });
                    }else{
                      //showSnackBar('write_something'.tr);
                    }

                  },
                  onLongPress: _messageController.text.isEmpty ? null : () {
                    if(_messageController.text.isNotEmpty){
                      setState(() {
                        _messageList.add(MessageModel(message: _messageController.text, isMe: false));
                        animateList();
                        _messageController.clear();
                      });
                    }else{
                      //showSnackBar('write_something'.tr);
                    }

                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SvgPicture.asset( _messageController.text.isNotEmpty ? AllImages.send : AllImages.attach, width: 24, height: 24,),
                  ),
                ),
                autocorrect: true,
                autofocus: false,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                decoration: const BoxDecoration(
                    color: ColorResources.colorGrey100,
                ),
                style: const TextStyle(color: Color(0xff252525)),
                textCapitalization: TextCapitalization.sentences,
                placeholder: 'Message',
                placeholderStyle: interRegular.copyWith(color: const Color(0xFF667085).withOpacity(0.8)),
                focusNode: _messageNode,
                controller: _messageController,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                minLines: 1,
                cursorColor: ColorResources.colorGrey700,
                cursorWidth: 1,
                textInputAction: TextInputAction.search,
                onSubmitted: (txt){
                  if(txt.isNotEmpty){
                    setState(() {
                      _messageList.add(MessageModel(message: txt, isMe: true));
                      animateList();
                      _messageController.clear();
                    });
                  }else{
                    //showSnackBar('write_something'.tr);
                  }
                },
                onChanged: (txt) {
                  setState(() {});
                },
              ),
            )
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        onTap: (){
          scrollController.animateTo(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        },
        child: Visibility(
          visible: _isActive,
          child: Container(
              margin: const EdgeInsets.only(bottom: 55, right: 10),
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),

              child: SvgPicture.asset(AllImages.downArrow, height: 24, width: 24,)),
        ),
      ),
    );
  }


  /// sender
  Widget _sender(String text){
    return ChatBubble(
      clipper: ChatBubbleClipper2(alignment: Alignment.bottomRight),
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: 20, right: 16),
      padding:  const EdgeInsets.fromLTRB(10, 8, 12,8),
      backGroundColor: ColorResources.colorPrimary,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: RichText(
          text: TextSpan(
            text: text,
            style: interRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.colorWhite),
            children: <TextSpan>[
              TextSpan(text: '   ${DateFormat('H:mm a').format(DateTime.now())}',
                style: Theme.of(context).textTheme.bodySmall?.merge(
                    interRegular.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: ColorResources.colorWhite
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// receiver
  Widget _receiver(String text){
    return ChatBubble(
      clipper: ChatBubbleClipper2(alignment:  Alignment.bottomRight),
      backGroundColor:const Color(0xFFF2F4F7),
      margin: const EdgeInsets.only(top: 20, left: 16),
      padding:  const EdgeInsets.fromLTRB(10,8, 10,8),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: RichText(
          text: TextSpan(
            text: text,
            style: interRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getTextColor(context),),
            children: <TextSpan>[
              TextSpan(text: '   ${DateFormat('H:mm a').format(DateTime.now())}',
                style: Theme.of(context).textTheme.bodySmall?.merge(
                    interRegular.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: ColorResources.colorPrimary
                    )
                ),
              ),
            ],
          ),
        ),
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
        this.radius = 8,
        this.nipHeight = 1,
        this.nipWidth = 0,
        this.nipRadius =0});

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
