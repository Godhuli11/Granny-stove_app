import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:main_food_ingrdients_app/base/custom_loader.dart';
import 'package:main_food_ingrdients_app/controllers/auth_controller.dart';
import 'package:main_food_ingrdients_app/controllers/cart_controller.dart';
import 'package:main_food_ingrdients_app/controllers/user_controller.dart';
import 'package:main_food_ingrdients_app/routes/route_helper.dart';
import 'package:main_food_ingrdients_app/utils/dimensions.dart';
import 'package:main_food_ingrdients_app/widgets/account_widget.dart';
import 'package:main_food_ingrdients_app/widgets/app_icon.dart';

import '../../models/user_model.dart';
import '../../models/user_model.dart';
import '../../models/user_model.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile", size: 24, color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?(userController.isLoading?Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              //profile icon
              AppIcon(icon: Icons.person,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height30+Dimensions.height45,
                size: Dimensions.height15*10,),
              SizedBox(height: Dimensions.height30,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //name
                      //bigText: BigText(text: userController.userModel?.name ?? 'Default Name'),

                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text:userController.userModel?.name??'Godhuli Bhattacharya' ,)),
                      SizedBox(height: Dimensions.height20,),
                      //phone
                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.phone,
                            backgroundColor: Colors.amberAccent,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: userController.userModel?.phone??'568884',)),
                      SizedBox(height: Dimensions.height20,),
                      //email
                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.email,
                            backgroundColor: Colors.amberAccent,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text:userController.userModel?.email??'@zyx.com',)),
                      SizedBox(height: Dimensions.height20,),
                      //address
                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.location_on,
                            backgroundColor: Colors.amberAccent,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: "Messages",)),
                      SizedBox(height: Dimensions.height20,),
                      //message
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn()){
                            Get.find<CartController>().clearCartHistory();
                            Get.find<CartController>().clear;
                            Get.find<AuthController>().clearSharedData;
                            Get.offNamed(RouteHelper.getSignInPage());
                          }
                        },
                        child: AccountWidget(
                            appIcon: AppIcon(icon: Icons.logout,
                              backgroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5,),
                            bigText: BigText(text: "Logout",)),
                      )
                    ],
                  ),
                ),
              )
              //SizedBox(height: Dimensions.height20,),
            ],
          ),
        ):CustomLoader()):Container(child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
            width: double.maxFinite,
            height: Dimensions.height20*8,
            margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        "assets/image/sign_in_to_continue.jpg"
                    )
                )
            ),
          ),
            GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getSignInPage());
              },
              child: Container(
                width: double.maxFinite,
                height: Dimensions.height20*5,
                margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                child: Center(child: BigText(text: "Sign in", color: Colors.white,size: Dimensions.fontSize20,)),
              ),
            )
            ],
        )),);
      }),
    );
  }
}
