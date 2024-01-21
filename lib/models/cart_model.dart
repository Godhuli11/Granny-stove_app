import 'package:main_food_ingrdients_app/models/products_model.dart';

class CartModel {
  int? id;
  String? name;
  int?quantity;
  int? price;
  bool? isExists;
  String? img;
  String? time;
  ProductModel?product;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.isExists,
    this.time,
    this.product
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      img: json['img'],
      quantity: json['quantity'],
      isExists: json['isExists'],
      time: json['time'],
      product:ProductModel.fromJson(json['product'])
    );
  }
  Map<String,dynamic>toJson(){
    return{
      "id":this.id,
      "name":this.name,
      "price":this.price,
      "img":this.img,
      "quantity":this.quantity,
      "isExist":this.isExists,
      "time":this.time,
      "product":this.product!.toJson()
    };

  }
}