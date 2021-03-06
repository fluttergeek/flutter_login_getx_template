import 'package:flutter/material.dart';
import 'package:flutter_login_getx_template/custom/BorderIcon.dart';
import 'package:flutter_login_getx_template/custom/OptionButton.dart';
import 'package:flutter_login_getx_template/screens/authentication/AuthController.dart';
import 'package:flutter_login_getx_template/screens/authentication/user.dart';
import 'package:flutter_login_getx_template/utils/constants.dart';
import 'package:flutter_login_getx_template/utils/widget_functions.dart';
import 'package:get/get.dart';

class LandingPage extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    var scaffoldKey = GlobalKey<ScaffoldState>();
    Get.put(UserController());

    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          drawer: new Drawer(
            child: new ListView(
              children: [
                GetX<UserController>(
                  init: UserController(),
                  initState: (_) async {
                    Get.find<UserController>().user = await UserController()
                        .getUser(Get.find<AuthController>().uid.toString());
                  },
                  builder: (_) {
                    return _.user.name != null
                        ? UserAccountsDrawerHeader(
                            currentAccountPicture:
                                CircleAvatar(child: Text(_.user.name[0])),
                            accountName: Text(_.user.name ?? "Loading"),
                            accountEmail: Text(_.user.email ?? "Loading"))
                        : Container();
                  },
                )
              ],
            ),
          ),
          body: Container(
            width: context.width,
            height: context.height,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BorderIcon(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.menu,
                              color: COLOR_BLACK,
                            ),
                            onTap: () {
                              scaffoldKey.currentState.openDrawer();
                            },
                          ),
                          BorderIcon(
                              height: 50,
                              width: 50,
                              child: Icon(
                                Icons.logout,
                                color: COLOR_BLACK,
                              ),
                              onTap: () {
                                Get.find<AuthController>().signOut();
                              }),
                        ],
                      ),
                    ),
                    addVerticalSpace(20),
                    Padding(
                      padding: sidePadding,
                      child: Text(
                        "City",
                        style: themeData.textTheme.bodyText2,
                      ),
                    ),
                    addVerticalSpace(10),
                    Padding(
                      padding: sidePadding,
                      child: Text(
                        "San Francisco",
                        style: themeData.textTheme.headline1,
                      ),
                    ),
                    Padding(
                        padding: sidePadding,
                        child: Divider(
                          height: 25,
                          color: COLOR_GREY,
                        )),
                    addVerticalSpace(10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          "<\$220,000",
                          "For Sale",
                          "3-4 Beds",
                          ">1000 sqft"
                        ].map((filter) => ChoiceOption(text: filter)).toList(),
                      ),
                    ),
                    addVerticalSpace(10),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  width: context.width,
                  child: Center(
                    child: OptionButton(
                      text: "Map View",
                      icon: Icons.map_rounded,
                      width: context.width * 0.35,
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class ChoiceOption extends StatelessWidget {
  final String text;

  const ChoiceOption({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: COLOR_GREY.withAlpha(25),
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      margin: const EdgeInsets.only(left: 20),
      child: Text(
        text,
        style: themeData.textTheme.headline5,
      ),
    );
  }
}
