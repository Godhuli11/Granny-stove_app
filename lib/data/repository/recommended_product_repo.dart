import 'package:get/get.dart';
import 'package:main_food_ingrdients_app/data/api/api_client.dart';
import 'package:main_food_ingrdients_app/utils/app_constants.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});


  Future<Response>  getRecommendedProductList () async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}