import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_projects/models/lawyer.dart';
import 'package:flutter_projects/ui/screens/log_in.dart';
import 'package:flutter_projects/ui/screens/log_in2.dart';
import 'package:flutter_projects/ui/screens/sign_up.dart';
import 'package:flutter_projects/ui/screens/user_type.dart';
import 'package:flutter_projects/ui/widgets/lawyer_list_item.dart';
import 'package:flutter_projects/ui/widgets/options_menu.dart';
import 'package:flutter_projects/viewModels/lawyer_viewModel.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/alert_dialog_item.dart';

class LawyersNearYou extends StatefulWidget {

  bool showFAB = false;

  LawyersNearYou({Key? key,  required this.showFAB}) : super(key: key);

  @override
  State<LawyersNearYou> createState() => _LawyersNearYouState();
}

class _LawyersNearYouState extends State<LawyersNearYou> {
  late Future<List<Lawyer>> _list;
  late Future<Position> _position;

  late ScrollController _pageScrollViewController;

  bool _showAppbar = true;
  bool _isScrollingDown = false;
  bool _isSearchActive = false;

  int _listItemIndex = 0;

  @override
  void initState() {
    super.initState();
    _list = Provider.of<LawyerAPIServices>(context, listen: false).fetchLawyers();
    _position = Provider.of<LawyerAPIServices>(context, listen: false)
        .determinePosition();
    _pageScrollViewController = ScrollController();
    _pageScrollViewController.addListener(() {
      if (_pageScrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!_isScrollingDown) {
          _isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_pageScrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_isScrollingDown) {
          _isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: widget.showFAB,
        child: getFAB(),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              height: _showAppbar ? 50.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: AppBar(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                backgroundColor: Colors.white,
                iconTheme: const IconThemeData(color: Colors.black),
                actions: [
                  !_isSearchActive
                      ? IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          _isSearchActive = true;
                        });
                      })
                      : IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _isSearchActive = false;
                        });
                      }),
                  OptionsMenuItems(list: _list, position: _position)
                ],
                title: !_isSearchActive
                    ? const Text('Lawyers list', style: TextStyle(color: Colors.black))
                    : _searchTextField(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  controller: _pageScrollViewController,
                  child: Column(
                    children: <Widget>[
                      Consumer<LawyerAPIServices>(
                        builder: (context, _, child) => FutureBuilder(
                          future: _list,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Lawyer>> snapshot) {
                            late Widget animatedSwitcherChild;
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              animatedSwitcherChild =
                              const CircularProgressIndicator(strokeWidth: 2);
                            }
                            else {
                              animatedSwitcherChild = ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                  const Divider(color: Colors.transparent, height: 2),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      child: LawyerWidget(lawyer: snapshot.data![index]),
                                      onTap: () {
                                        _listItemIndex = index;
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return _getAlertDialog(snapshot);
                                            });
                                      },
                                    );
                                  });
                            }
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: animatedSwitcherChild,
                              transitionBuilder: (child, animation) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.0, 0.2),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageScrollViewController.dispose();
    _pageScrollViewController.removeListener(() {});
    super.dispose();
  }

  _getAlertDialog(AsyncSnapshot<List<Lawyer>> snapshot) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemCount: 5,
            separatorBuilder: (_, index) => const Divider(height: 30),
            itemBuilder: (context, index) {
              List<IconData> icons = [
                Icons.gps_fixed,
                Icons.email_outlined,
                Icons.call,
                Icons.link,
                Icons.bookmark_add_outlined
              ];

              List<String> actions = [
                'View on map',
                'Send email',
                'Call lawyer',
                'Visit website',
                'Appointment booking'
              ];

              return InkWell(
                child: AlertDialogItem(
                  icon: icons[index],
                  action: actions[index],
                ),
                onTap: () {
                  Navigator.pop(context);
                  switch (index) {
                    case 0: {
                      if (snapshot.data![_listItemIndex].data.location!.latitude != null) {
                        MapUtils.openMap(
                            double.parse(snapshot.data![_listItemIndex].data
                                .location!.latitude!),
                            double.parse(snapshot.data![_listItemIndex].data
                                .location!.longitude!));
                      } else {
                        final snackBar = SnackBar(
                          content:
                          const Text("This lawyer don't have a location"),
                          duration: const Duration(seconds: 5),
                          action: SnackBarAction(
                            label: 'Dismiss',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                    break;
                    case 1: {
                      if (snapshot.data![_listItemIndex].data.email != null) {
                        final Uri params = Uri(
                            scheme: 'mailto',
                            path: snapshot.data![_listItemIndex].data.email
                        );
                        launchUrl(params);
                      } else {
                        final snackBar = SnackBar(
                          content:
                          const Text("This lawyer don't have a location"),
                          duration: const Duration(seconds: 5),
                          action: SnackBarAction(
                            label: 'Dismiss',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                    break;
                    case 2: {
                      if (snapshot.data![_listItemIndex].data.phone != null) {
                        launch('tel:${snapshot.data![_listItemIndex].data.phone}');
                      } else {
                        final snackBar = SnackBar(
                          content:
                          const Text("This lawyer don't have a location"),
                          duration: const Duration(seconds: 5),
                          action: SnackBarAction(
                            label: 'Dismiss',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                    break;
                    case 3: {
                      if (snapshot.data![_listItemIndex].data.website != null) {
                        String url = '${snapshot.data![_listItemIndex].data.website}';
                        launch(url);
                      }
                      else {
                        final snackBar = SnackBar(
                          content:
                          const Text("This lawyer don't have a location"),
                          duration: const Duration(seconds: 5),
                          action: SnackBarAction(
                            label: 'Dismiss',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                    break;
                    case 4: {
                      if (snapshot.data![_listItemIndex].data.website != null) {
                        String url = '${snapshot.data![_listItemIndex].data.website}';
                        launch(url);
                      }
                      else {
                        final snackBar = SnackBar(
                          content:
                          const Text("This lawyer don't have a location"),
                          duration: const Duration(seconds: 5),
                          action: SnackBarAction(
                            label: 'Dismiss',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  }
                },
              );
            },
          ),
        ],
      ),
    );

  Widget _searchTextField() {
    return TextField(
      decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: "Search for lawyer"),
    );
  }

  Widget getFAB() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(size: 22),
      backgroundColor: Colors.black,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
            child: const Icon(Icons.login, color: Colors.amber),
            backgroundColor: Colors.black,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LogIn()));
            },
            label: 'Log in',
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.amber,
                fontSize: 16.0),
            labelBackgroundColor: Colors.black),
        SpeedDialChild(
            child: const Icon(Icons.app_registration_outlined, color: Colors.amber),
            backgroundColor: Colors.black,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUp()));
            },
            label: 'Sign up',
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.amber,
                fontSize: 16.0),
            labelBackgroundColor: Colors.black)
      ],
    );
  }
}
