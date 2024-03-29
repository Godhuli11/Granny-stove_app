import 'package:get/get_connect/http/src/response/response.dart';
import 'package:main_food_ingrdients_app/data/api/api_client.dart';
import 'package:main_food_ingrdients_app/models/user_model.dart';
import 'package:main_food_ingrdients_app/utils/app_constants.dart';

class UserRepo{
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response>getUserInfo() async{
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }
}