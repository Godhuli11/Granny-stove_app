import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:main_food_ingrdients_app/routes/route_helper.dart';

import '../../controllers/popular_product_controllers.dart';
import '../../controllers/recommended_product_controler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState(){
    super.initState();
    _loadResource();
    controller = new AnimationController(vsync: this , duration: Duration(seconds: 2))..forward();

    animation = new CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
    );

    Timer(
       const Duration(seconds: 3),
        ()=>Get.offNamed(RouteHelper.getInitial())
    );
    // Use Future.wait to wait for both the timer and animation to complete
    // Future.wait([
    //   Future.delayed(const Duration(seconds: 3)),
    //   controller.forward(),
    // ]).then((_) {
    //   Get.offNamed(RouteHelper.getInitial());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: ScaleTransition(
                scale: animation,
                  child: Image.asset("assets/image/logo_1.png",width: 300,))),

        ],
      ),
    );
  }
}
