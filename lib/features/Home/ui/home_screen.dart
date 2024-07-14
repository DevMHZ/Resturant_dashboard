import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:my_resturant_dashboard/features/my_resturant/view/my_restu_screen.dart';
import '../../Editing_Resturant_Info/view/editing_screen.dart';

class DashboardHomeScreen extends StatefulWidget {
  const DashboardHomeScreen({Key? key}) : super(key: key);

  @override
  _DashboardHomeScreenState createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen> {
  final PageController pageController = PageController();
  final SideMenuController sideMenuController = SideMenuController();

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      sideMenuController.changePage(pageController.page!.toInt());
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    sideMenuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            SideMenu(
              controller: sideMenuController,
              style: SideMenuStyle(
                displayMode: SideMenuDisplayMode.auto,
                hoverColor: Colors.redAccent,
                selectedColor: Colors.yellow,
                selectedTitleTextStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                selectedIconColor: Colors.white,
                unselectedTitleTextStyle: const TextStyle(color: Colors.black),
                unselectedIconColor: Colors.black54,
                backgroundColor: Colors.grey[300],
                openSideMenuWidth: 250,
                compactSideMenuWidth: 70,
                toggleColor: Colors.yellow,
                itemHeight: 60,
                iconSize: 24,
              ),
              items: [
                SideMenuItem(
                  title: '',
                  trailing: Text('معلومات المطعم'),
                  iconWidget: Icon(Icons.restaurant),
                  onTap: (index, controller) {
                    pageController.jumpToPage(0);
                    controller.changePage(index);
                  },
                ),
                SideMenuItem(
                  title: '',
                  trailing: Text('تعديل معلومات المطعم'),
                  iconWidget: Icon(Icons.edit),
                  onTap: (index, controller) {
                    pageController.jumpToPage(1);
                    controller.changePage(index);
                  },
                ),
              ],
              onDisplayModeChanged: (mode) {
                print(mode);
              },
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                  MyResturantMainScreen(),
                  EditRestaurantInfoView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
