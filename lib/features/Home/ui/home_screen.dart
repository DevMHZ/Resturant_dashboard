import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:my_resturant_dashboard/Features/Editing_Resturant_Info/view/editing_screen.dart';
import 'package:my_resturant_dashboard/features/my_resturant/view/my_restu_screen.dart';

class DashboardHomeScreen extends StatefulWidget {
  const DashboardHomeScreen({
    super.key,
  });

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardHomeScreen> {
  final PageController pageController = PageController();
  final SideMenuController sideMenuController = SideMenuController();

  @override
  void initState() {
    super.initState();

    // Listen to page changes and update side menu selection
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
              key: const Key('side_menu'),
              controller: sideMenuController,
              style: SideMenuStyle(
                displayMode: SideMenuDisplayMode.auto,
                hoverColor: Colors.blue[100],
                selectedColor: Colors.lightBlue,
                selectedTitleTextStyle: const TextStyle(color: Colors.white),
                selectedIconColor: Colors.white,
                unselectedTitleTextStyle: const TextStyle(color: Colors.black),
                unselectedIconColor: Colors.black54,
                backgroundColor: Colors.grey[200],
                openSideMenuWidth: 200,
                compactSideMenuWidth: 40,
              ),
              items: [
                SideMenuItem(
                  title: '  مطعمي',
                  onTap: (index, controller) {
                    pageController.jumpToPage(0);
                    controller.changePage(index);
                  },
                ),
                SideMenuItem(
                  title: 'تعديل معلومات المطعم',
                  onTap: (index, controller) {
                    pageController.jumpToPage(1);
                    controller.changePage(index);
                  },
                ),
              ],
              onDisplayModeChanged: (mode) {
                print(mode);
              },
              showToggle: true,
              alwaysShowFooter: false,
              collapseWidth: 600,
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                children: [MyResturantMainScreen(), EditRestaurantInfoView()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
