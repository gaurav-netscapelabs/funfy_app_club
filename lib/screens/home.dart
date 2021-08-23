import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy_scanner/Constants/fontsDisplay.dart';
import 'package:funfy_scanner/Constants/routes.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/Models/ApiCaller.dart';
import 'package:funfy_scanner/Models/UserProfileDataModal.dart';
import 'package:funfy_scanner/Models/bookingListModal.dart';
import 'package:funfy_scanner/screens/pastTicketsList.dart';
import 'package:funfy_scanner/screens/profilePage.dart';
import 'package:funfy_scanner/screens/profileScreen.dart';
import 'package:funfy_scanner/screens/qr_code_scanner.dart';
import 'package:funfy_scanner/widgets/widgets.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int? index;
  bool _isLoading = false;
  late GetUserProfileModal userAddData = GetUserProfileModal();
  BookingListModal getBookingData = BookingListModal();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getUserData();
    getBookingList();
  }

  //for Booking List Screen
  getBookingList() {
    UserData.getUserToken("USERTOKEN").then((userToken) {
      print(userToken);
      ApiCaller().getBookingList(userToken).then((getBookingListData) {
        print(getBookingListData);
        // print(
        //     "Booking List Data=====>>>${(getBookingListData as BookingListModal).data!.data![0].totalPrice}");
        setState(() {
          getBookingData = getBookingListData;
          print(getBookingData.data!.data![1].totalPrice);
        });
      });
    });
  }

//for Profile Screen
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

// logout User
  logoutmethod() {
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
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          //Qr code Scanner
          QRData(),
          //shown Past Tickets List
          PastTicketsList(
            showBookingList: getBookingData,
          ),
          //Profile Screen
          buildProfileScreen(
            _isLoading,
            userAddData,
            size,
            context,
            logoutmethod,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 65,
        alignment: Alignment.bottomCenter,
        color: Color(0xff3E332B),
        child: TabBar(
            indicatorColor: Colors.transparent,
            onTap: (value) {
              setState(() {
                index = value;
              });
              print(index);
            },
            controller: _tabController,
            tabs: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/camera.png",
                    color: index == 0 ? Color(0xffFFFFFF) : Color(0xffC5C5C5),
                  ),
                  Text(
                    "Qr Code",
                    style: TextStyle(
                      color: index == 0 ? Color(0xffFFFFFF) : Color(0xffC5C5C5),
                      fontFamily: index == 0
                          ? FontsDisPlay.robotoMedium
                          : FontsDisPlay.robotoRegular,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/ticket.png",
                    color: index == 1 ? Color(0xffFFFFFF) : Color(0xffC5C5C5),
                  ),
                  Text(
                    "Past Tickets",
                    style: TextStyle(
                      color: index == 1 ? Color(0xffFFFFFF) : Color(0xffC5C5C5),
                      fontFamily: index == 1
                          ? FontsDisPlay.robotoMedium
                          : FontsDisPlay.robotoRegular,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/setting.png",
                    color: index == 2 ? Color(0xffFFFFFF) : Color(0xffC5C5C5),
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                      color: index == 2 ? Color(0xffFFFFFF) : Color(0xffC5C5C5),
                      fontFamily: index == 2
                          ? FontsDisPlay.robotoMedium
                          : FontsDisPlay.robotoRegular,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
