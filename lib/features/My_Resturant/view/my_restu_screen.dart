import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_resturant_dashboard/Features/My_Resturant/controller/my_restu_controller.dart';
import 'package:my_resturant_dashboard/features/My_Resturant/widgets/build_card.dart';
import '../widgets/info_widget.dart';

class MyResturantMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyResturantMainScreenController userController =
        Get.put(MyResturantMainScreenController());

    return Scaffold(
      body: Obx(() {
        if (userController.userData.value.subDomain == '') {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            padding: EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'معلومات المطعم',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 16),
                buildCard(
                  context,
                  children: [
                    InfoRow(
                      label: 'Sub Domain',
                      value: userController.userData.value.subDomain,
                      icon: Icons.language,
                    ),
                    InfoRow(
                      label: 'الاسم',
                      value: userController.userData.value.name,
                      icon: Icons.restaurant,
                    ),
                    InfoRow(
                      label: 'الاسم التايتل',
                      value: userController.userData.value.titleName,
                      icon: Icons.label,
                    ),
                    InfoRow(
                      label: 'الرقم',
                      value: userController.userData.value.phone,
                      icon: Icons.phone,
                    ),
                    InfoRow(
                      label: 'تاريخ انتهاء صلاحية الاشتراك',
                      value: userController.userData.value.endDate,
                      icon: Icons.calendar_today,
                    ),
                    InfoRow(
                      label: 'صورة المطعم',
                      value: userController.userData.value.profileimg,
                      icon: Icons.image,
                    ),
                    InfoRow(
                      label: 'اللون الرئيسي',
                      value: userController.userData.value.mainColor,
                      icon: Icons.color_lens,
                    ),
                    InfoRow(
                      label: 'القسم الرئيسي',
                      value:
                          userController.userData.value.mainCategory.join(", "),
                      icon: Icons.restaurant_menu,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Sub Categories',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          userController.userData.value.subCategory.length,
                      itemBuilder: (context, index) {
                        var subCategory =
                            userController.userData.value.subCategory[index];
                        return buildCard(
                          context,
                          children: [
                            InfoRow(
                              label: 'القسم الرئيسي',
                              value: subCategory.mainCategory,
                              icon: Icons.restaurant_menu,
                            ),
                            InfoRow(
                              label: 'الاسم',
                              value: subCategory.name,
                              icon: Icons.label,
                            ),
                            InfoRow(
                              label: 'السعر',
                              value: subCategory.price,
                              icon: Icons.attach_money,
                            ),
                            InfoRow(
                              label: 'صورة',
                              value: subCategory.img,
                              icon: Icons.image,
                            ),
                            InfoRow(
                              label: 'الوصف',
                              value: subCategory.description,
                              icon: Icons.description,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
