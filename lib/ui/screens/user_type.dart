import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projects/ui/screens/lawyer_near_you.dart';
import 'package:flutter_projects/ui/screens/lawyer.dart';
import 'package:flutter_projects/ui/screens/notifications.dart';
import 'package:flutter_projects/ui/screens/meetings.dart';


class UserType extends StatefulWidget {
  final String title, type;

  UserType({Key? key, required this.title, required this.type}) : super(key: key);

  @override
  _UserTypeState createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> with TickerProviderStateMixin {
  // final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0;

  // late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  // late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  // late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final _navIconList = <IconData>[
    Icons.home_outlined,
    Icons.assured_workload_outlined,
    Icons.verified_user_outlined,
    Icons.notifications_none,
  ];

  final _navTextList = [
    'Lawyers',
    'My offices',
    'Appointments',
    'Notifications'
  ];

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: HexColor('#373A36'),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);
    // _fabAnimationController = AnimationController(
    //   duration: Duration(milliseconds: 500),
    //   vsync: this,
    // );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    // fabCurve = CurvedAnimation(
    //   parent: _fabAnimationController,
    //   curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    // );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    //
    // fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Future.delayed(
    //   Duration(seconds: 1),
    //       () => _fabAnimationController.forward(),
    // );
    Future.delayed(
      const Duration(seconds: 1),
          () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          // _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          // _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        fontFamily: 'main_font'
      ),
      child: Scaffold(
        // extendBody: true,
        // appBar: AppBar(
        //   shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(
        //       bottom: Radius.circular(30),
        //     ),
        //   ),
        //   title: Text(
        //     widget.title,
        //     style: const TextStyle(color: Colors.white),
        //   ),
        //   backgroundColor: HexColor('#373A36'),
        // ),
        body: NotificationListener<ScrollNotification>(
          onNotification: onScrollNotification,
          child: getNavScreen(_bottomNavIndex),
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: _navIconList.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? HexColor('#FFA400') : Colors.white;
            return Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _navIconList[index],
                  size: 24,
                  color: color,
                ),
                const SizedBox(height: 4),
             Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                      _navTextList[index],
                    style: TextStyle(color: color, fontSize: 9)
                  ),
                )
              ],
            );
          },
          height: 70,
          backgroundColor: HexColor('#373A36'),
          activeIndex: _bottomNavIndex,
          splashColor: HexColor('#FFA400'),
          notchAndCornersAnimation: borderRadiusAnimation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.sharpEdge,
          gapLocation: GapLocation.none,
          leftCornerRadius: 30,
          rightCornerRadius: 30,
          onTap: (index) => setState(() {
            _bottomNavIndex = index;
          }),
          hideAnimationController: _hideBottomBarAnimationController,
        ),
      ),
    );
  }

  Widget getNavScreen(int navIndex) {
    switch (navIndex){
      case 0: return LawyersNearYou(showFAB: false);
      case 1: return const Lawyer();
      case 2: return Meetings(type: widget.type);
      case 3: return const Notifications();
      default: {
        return LawyersNearYou(showFAB: false);
      }
    }
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}