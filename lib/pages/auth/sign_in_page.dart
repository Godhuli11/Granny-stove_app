import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:main_food_ingrdients_app/base/custom_loader.dart';
import 'package:main_food_ingrdients_app/pages/auth/sign_up_page.dart';
import 'package:main_food_ingrdients_app/routes/route_helper.dart';
import 'package:main_food_ingrdients_app/utils/colors.dart';
import 'package:main_food_ingrdients_app/utils/dimensions.dart';
import 'package:main_food_ingrdients_app/widgets/app_text_field.dart';
import 'package:main_food_ingrdients_app/widgets/big_text.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    void _login(AuthController authController){

      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

     if(phone.isEmpty){
        showCustomSnackBar("Type in your email",title: "Email");
      }else if(GetUtils.isEmail(phone)){
        showCustomSnackBar("Type in a valid email address",title: "Valid email");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password",title: "password");
      }else if(password.length<6){
        showCustomSnackBar("Password cannot be less than 6 characters",title: "Password");
      }else{
        //showCustomSnackBar("All went well",title: "Perfect");

        authController.login(phone,password).then((status){
          if(status.isSuccess){
            //showCustomSnackBar("All went well",title: "Perfect");
            Get.toNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
         return !authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //app logo
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                        "assets/image/logo_1.png"
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: Dimensions.font20*3+Dimensions.font20/2,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "Sign in to your account",
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          color: Colors.grey[500]
                        //fontWeight: FontWeight.bold
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              //email
              AppTextField(
                  textController: phoneController,
                  hintText: "email",
                  icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              //password
              AppTextField(
                textController: passwordController,
                hintText: "password",
                icon: Icons.password_sharp,isObscure: true,),
              SizedBox(height: Dimensions.height20,),

              SizedBox(height: Dimensions.height20,),
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(
                      text: TextSpan(
                          text: "Sign into your account",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.fontSize20
                          )
                      )),
                  SizedBox(width: Dimensions.width20,)
                ],
              ),

              SizedBox(height: Dimensions.screenHeight*0.05,),
              //Sign in
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign in ",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //sign up options
              RichText(
                  text: TextSpan(
                      text: "Don\'t have an account? ",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.fontSize20
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                          text: " Create",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: Dimensions.fontSize20
                          ),
                        )
                      ]
                  )
              ),
              // Wrap(
              //   children: List.generate(3, (index) => Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: CircleAvatar(
              //       radius: Dimensions.radius30,
              //       backgroundImage: AssetImage(
              //         "assets/image/"+signUpImages[index],
              //       ),
              //     ),
              //   ))
              // )

            ],
          ),
        ):CustomLoader();
      }),
    );
  }
}
