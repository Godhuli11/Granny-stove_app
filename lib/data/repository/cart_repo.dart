import 'dart:convert';

import 'package:main_food_ingrdients_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo{
   final   SharedPreferences sharedPreferences;
   CartRepo({required this.sharedPreferences});

   List<String> cart = [];
   List<String> cartHistory=[];



   void addToCartList(List<CartModel> cartList){
         var time = DateTime.now().toString();
          cart=[];
          cartList.forEach((element) {
             element.time = time;
             return cart.add(jsonEncode(element));
          });

          sharedPreferences.setStringList(AppConstants.CART_lIST, cart);
   }

     void removeCart(){
      cart=[];
      sharedPreferences.remove(AppConstants.CART_lIST);
     }

     void clearCartHistory(){
       removeCart();
       cartHistory=[];
       sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
     }

     List<CartModel> getCartHistoryList(){
        if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
          cartHistory=[];
          cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
        }
        List<CartModel> cartListHistory = [];
        cartHistory.forEach((element)=> cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
        return cartListHistory;
     }
   List<CartModel> getCartList(){
     List<String> carts = [];
     if(sharedPreferences.containsKey(AppConstants.CART_lIST)){
       carts = sharedPreferences.getStringList(AppConstants.CART_lIST)!;
     }
     List<CartModel> cartList = [];
     carts.forEach((element)=>cartList.add(CartModel.fromJson(jsonDecode(element))));
     return cartList;
   }

   void addToCartHistoryList(){
     if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
       cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
     }
     for(int i=0 ; i<cart.length ; i++){
              cartHistory.add(cart[i]);
     }
     removeCart();
     sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
   }
}