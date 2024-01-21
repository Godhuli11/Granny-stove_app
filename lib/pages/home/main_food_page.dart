import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:main_food_ingrdients_app/utils/colors.dart';
import 'package:main_food_ingrdients_app/widgets//big_text.dart' ;
import 'package:main_food_ingrdients_app/widgets/small_text.dart';

import '../../controllers/popular_product_controllers.dart';
import '../../controllers/recommended_product_controler.dart';
import '/utils/dimensions.dart';
import 'food_page_body.dart';


class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);
  @override
  State<MainFoodPage> createState() => _State();
}

Future<void> _loadResource() async {
  await Get.find<PopularProductController>().getPopularProductList();
  await Get.find<RecommendedProductController>().getRecommendedProductList();
}
class _State extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
   // print("Current Height is"+MediaQuery.of(context).size.height.toString());
    return RefreshIndicator(child:  Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.width15),
          padding: EdgeInsets.only(left:Dimensions.width20,right:Dimensions.width20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  BigText(text: "India", color : AppColors.mainColor,),
                  Row(
                    children: [
                      SmallText(text: "Kolkata", color: Colors.black54,),
                      Icon(Icons.arrow_drop_down_rounded),
                    ],
                  ),
                ],
              ),
              Center(
                child: Container(
                  child: Icon(Icons.search,color: Colors.white,size:Dimensions.iconSize24),
                  width: Dimensions.height45,
                  height: Dimensions.height45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: AppColors.mainColor,
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(child: SingleChildScrollView(
          child: FoodPageBody(),
        )),
      ],
    ), onRefresh: _loadResource);
  }
}
