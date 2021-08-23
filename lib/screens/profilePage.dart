import 'package:cached_network_image/cached_network_image.dart';
import 'package:funfy_scanner/screens/LoadingScreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';
import 'package:funfy_scanner/Constants/routes.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/Models/ApiCaller.dart';
import 'package:funfy_scanner/Models/UserProfileDataModal.dart';
import 'package:get/get.dart';

class Profilepage extends StatefulWidget {


  Profilepage({
    Key? key,

  }) : super(key: key);

  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  bool toggleBool = false;
  bool notiLoading = false;
  bool _isLoading = false;
  bool isOneTime = true;
  late GetUserProfileModal userAddData = GetUserProfileModal();

  static GlobalKey<ScaffoldState> _keyScaffold = GlobalKey();

  void showNotificationBottomSheet() {
    var size = MediaQuery.of(context).size;
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            key: _keyScaffold,
            builder: (context, setstate) {
              return Container(
                margin: EdgeInsets.only(top: size.height * 0.008),
                // color: Colors.white,
                height: size.height * 0.5,
                width: size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.008,
                    ),

                    SizedBox(
                      height: size.height * 0.04,
                    ),

                    SizedBox(
                      height: size.height * 0.05,
                    ),

                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   "Notification Alerts",
                              //   style: TextStyle(
                              //     color: HexColor("#4e4e4e"),
                              //     fontSize: size.width * 0.065,
                              //     fontFamily: Fonts.dmSansMedium,
                              //   ),
                              // ),
                              // Text(
                              //   "${toggleBool ? getTranslated(
                              //       context, "switchOn") : getTranslated(
                              //       context, "switchoff")}",
                              //   style: TextStyle(
                              //     color: HexColor("#aeaeae"),
                              //     fontSize: size.width * 0.045,
                              //     fontFamily: Fonts.dmSansMedium,
                              //   ),
                              // ),
                            ],
                          ),
                          Spacer(),
                          // notiLoading
                          //     ? Container(
                          //   margin:
                          //   EdgeInsets.only(top: size.height * 0.02),
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.end,
                          //     children: [
                          //       Container(
                          //         // height: size.height * 0.03,
                          //         // width: size.width * 0.06,
                          //           height: 20,
                          //           width: 20,
                          //           child: CircularProgressIndicator()),
                          //       SizedBox(
                          //         width: size.width * 0.04,
                          //       )
                          //     ],
                          //   ),
                          // )
                          //     : Switch(
                          //   onChanged: (v) async {
                          //     setstate(() {
                          //       notiLoading = true;
                          //     });
                          //
                          //     await notificationOffApi(
                          //         notificationNum: v ? 1 : 0)
                          //         .then((value) {
                          //       print("res value $value");
                          //       setstate(() {
                          //         notiLoading = false;
                          //         toggleBool = value!;
                          //       });
                          //     });
                          //
                          //     setstate(() {
                          //       notiLoading = false;
                          //     });
                          //   },
                          //   value: toggleBool,
                          //   activeColor: AppColors.white,
                          //   activeTrackColor: AppColors.siginbackgrond,
                          //   inactiveThumbColor: AppColors.white,
                          //   inactiveTrackColor: Colors.grey[300],
                          // )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.06,
                    ),

                    // InkWell(
                    //   onTap: () {
                    //     navigatePopFun(context);
                    //     navigatorPushFun(context, Notifications());
                    //   },
                    //   child: Text(
                    //     "${getTranslated(context, "SeeAllNotifications")}",
                    //     style: TextStyle(
                    //       color: HexColor("#2f2c2c"),
                    //       fontSize: size.width * 0.05,
                    //       fontFamily: Fonts.dmSansBold,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          );
        });
  }

  // @override
  // void initState() {
  //   super.initState();
  //
  //   getUserData();
  // }

  getUserData() {
    setState(() {
      _isLoading = true;
    });
    UserData.getUserToken("USERTOKEN").then((userToken) {
      ApiCaller().getUserProfile(userToken, context).then((userData) {
        // print((userData as GetUserProfileModal).data!.email);
        setState(() {
          userAddData = (userData);
          _isLoading = false;
        });
      });
    });
  }

  @override
  void didChangeDependencies() {
    if (isOneTime) {
      getUserData();
    }
    setState(() {
      isOneTime = false;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return _isLoading
        ? LoadingScreen()
        : Container(
            color: Colors.grey[900],
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.035),
                  child: Column(
                    children: [
                      // top content
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // image
                          CircleAvatar(
                            radius: size.width * 0.085,
                            backgroundImage:
                                AssetImage("assets/images/defaultImage.png"),
                            backgroundColor: Colors.white,
                          ),

                          SizedBox(
                            width: size.width * 0.02,
                          ),

                          // name email
                          Expanded(
                            flex: 8,
                            child: Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${userAddData.data?.name} ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: FontsDisPlay.dmSantsBold,
                                          color: Colors.white,
                                          fontSize: size.width * 0.058),
                                    ),
                                    Text(
                                      "${userAddData.data?.email}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily:
                                              FontsDisPlay.dmSantsRegular,
                                          color: Colors.grey,
                                          fontSize: size.width * 0.046),
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                        // edit
                      ),

                      SizedBox(height: size.height * 0.090),
//Languages
                      centerlistItem(
                          context: context,
                          title: "languages",
                          // rightIconImage: ,
                          leftIconImage: "assets/images/expand.png",
                          onTapfunc: () {}),
                      //Help
                      centerlistItem(
                          context: context,
                          title: "Help",
                          // Help: ,
                          leftIconImage: "assets/images/expand.png",
                          onTapfunc: () {}),
//Contact Us
                      centerlistItem(
                          context: context,
                          title: "Contact Us",
                          // rightIconImage: ,
                          leftIconImage: "assets/images/expand.png",
                          onTapfunc: () {}),
                      SizedBox(
                        height: size.height * 0.18,
                      ),

                      InkWell(
                        onTap: () {
                          setState(() {
                            _isLoading = true;
                          });
                          UserData.getUserToken("USERTOKEN").then(
                            (token) => ApiCaller().logout(token).then(
                              (value) {
                                setState(() {
                                  _isLoading = false;
                                });
                                return Get.toNamed(Routes.signInScreen);
                              },
                            ),
                          );
                        },
                        child: _isLoading
                            ? CircularProgressIndicator(
                                color: Color(0xffFF5349),
                              )
                            : Container(
                                width: size.width * 0.60,
                                height: size.height * 0.060,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey[600],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: size.height * 0.030,
                                      width: size.width * 0.10,
                                      margin: EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "assets/images/logout.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: size.width * 0.090),
                                    Text(
                                      "Log Out",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),

                      // logout
                      //
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Container(
                      //       height: size.height * 0.065,
                      //       width: size.width * 0.6,
                      //       decoration: BoxDecoration(
                      //         color: Colors.grey.shade600,
                      //         borderRadius: BorderRadius.circular(8),
                      //       ),
                      //       child: Align(
                      //           alignment: Alignment.center,
                      //           child: Row(
                      //             children: [
                      //               SizedBox(width: size.width * 0.045),
                      //               Container(
                      //                   // color: Colors.green,
                      //                   height: size.height * 0.031,
                      //                   width: size.width * 0.06,
                      //                   child:
                      //                       Image.asset("assets/images/logout.png")),
                      //               SizedBox(
                      //                 width: size.width * 0.12,
                      //               ),
                      //               Text(
                      //                 "log Out",
                      //                 //   Strings.logout,
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontFamily: FontsDisPlay.dmSantsBold,
                      //                     fontSize: size.width * 0.045),
                      //               ),
                      //             ],
                      //           ))),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

Widget centerlistItem(
    {context,
    String? leftIconImage,
    String? title,
    String? rightIconImage,
    onTapfunc}) {
  var size = MediaQuery.of(context).size;

  return InkWell(
    onTap: () {
      onTapfunc();
    },
    child: Container(
      margin: EdgeInsets.only(top: size.height * 0.02),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Container(
                      alignment: Alignment.center,
                      width: size.width * 0.045,
                      color: Colors.grey[300],
                      child: Image.asset("$leftIconImage")),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(
                    title.toString(),
                    style: TextStyle(
                        fontFamily: FontsDisPlay.dmSantsRegular,
                        color: Colors.white,
                        fontSize: size.width * 0.04),
                  ),
                ]),
                Container(
                  alignment: Alignment.center,
                  width: size.width * 0.06,
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: size.width * 0.07,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Divider(
            color: Colors.white,
            thickness: size.height * 0.0003,
          ),
        ],
      ),
    ),
  );
}
