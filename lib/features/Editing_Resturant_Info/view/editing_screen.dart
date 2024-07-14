import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_resturant_dashboard/core/helpers/spacing.dart';
import '../controller/editing_info_controller.dart';
import '../widgets/card_color_editing.dart';
import '../widgets/main_category.dart';
import '../widgets/main_color_editing.dart';
import '../widgets/resturant_information.dart';
import '../widgets/social_media.dart';
import '../widgets/sub_category.dart';

class EditRestaurantInfoView extends StatelessWidget {
  final EditRestaurantInfoController controller =
      Get.put(EditRestaurantInfoController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: Colors.grey[200],
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return _buildUI(context);
        }
      }),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(26.0),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildHeader(context, 'معلومات المطعم'),
                        verticalSpace(20),
                        buildRestaurantInformation(context),
                        verticalSpace(20),
                        buildHeader(context, 'تعديل الألوان الخاصة بالمطعم'),
                        verticalSpace(10),
                        buildColorPicker(context),
                        verticalSpace(20),
                        buildCardColorPicker(context),
                        verticalSpace(20),
                        buildHeader(
                            context, 'تعديل الأقسام الرئيسية و الأطباق'),
                        verticalSpace(10),
                        buildMainCategoryEditor(context),
                        verticalSpace(20),
                        buildHeader(context, 'تعديل الأطباق'),
                        verticalSpace(10),
                        buildSubCategoryEditor(context),
                        verticalSpace(20),
                        buildHeader(context, 'تعديل حسابات التواصل الاجتماعي'),
                        verticalSpace(10),
                        buildSocialMediaAccountsEditor(context),
                        verticalSpace(20),
                        _buildUpdateButton(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            controller.updateRestaurantData(context);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        child: Text(
          'تحديث المعلومات',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
