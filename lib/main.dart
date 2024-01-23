import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_food_ingrdients_app/controllers/cart_controller.dart';
import 'package:main_food_ingrdients_app/controllers/popular_product_controllers.dart';
import 'package:main_food_ingrdients_app/pages/account/account_page.dart';
import 'package:main_food_ingrdients_app/pages/address/add_address_page.dart';
import 'package:main_food_ingrdients_app/pages/address/pick_address_map.dart';
import 'package:main_food_ingrdients_app/pages/auth/sign_in_page.dart';
import 'package:main_food_ingrdients_app/pages/auth/sign_up_page.dart';
import 'package:main_food_ingrdients_app/pages/cart/cart_page.dart';
import 'package:main_food_ingrdients_app/pages/food/popular_food_detail.dart';
import 'package:main_food_ingrdients_app/pages/food/recommended_food_detail.dart';
import 'package:main_food_ingrdients_app/pages/home/food_page_body.dart';
import 'package:main_food_ingrdients_app/pages/splash/splash_page.dart';
import 'package:main_food_ingrdients_app/routes/route_helper.dart';
import 'package:main_food_ingrdients_app/utils/colors.dart';
import 'controllers/recommended_product_controler.dart';
import 'pages/home/main_food_page.dart';
import 'helper/dependencies.dart'as dep;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
          //home: SplashScreen(),
          home:PickAddressMap(fromSignUp: true, fromAddress: true,),
         //initialRoute: RouteHelper.getSplashPage(),
        // getPages: RouteHelper.routes,
         theme: ThemeData(
           primaryColor: AppColors.mainColor,
           fontFamily: 'Lato',
         ),
        );
      });
    });
  }
}

