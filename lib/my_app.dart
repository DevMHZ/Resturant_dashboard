import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_resturant_dashboard/core/routing/app_router.dart';
import 'package:my_resturant_dashboard/core/theming/colors.dart';
import 'core/routing/routes.dart';

class RestDashApp extends StatelessWidget {
  final AppRouter appRouter;
  const RestDashApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: GetMaterialApp(
          title: 'Dashboard Screen',
          textDirection: TextDirection.rtl,
          theme: ThemeData(
            primaryColor: AppColor.appBlueColor,
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.root,
          onGenerateRoute: appRouter.generateRoute,
        ));
  }
}
