import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:main_food_ingrdients_app/base/custom_loader.dart';
import 'package:main_food_ingrdients_app/base/show_custom_snackbar.dart';
import 'package:main_food_ingrdients_app/controllers/auth_controller.dart';
import 'package:main_food_ingrdients_app/models/signup_body_model.dart';
import 'package:main_food_ingrdients_app/routes/route_helper.dart';
import 'package:main_food_ingrdients_app/utils/colors.dart';
import 'package:main_food_ingrdients_app/utils/dimensions.dart';
import 'package:main_food_ingrdients_app/widgets/app_text_field.dart';
import 'package:main_food_ingrdients_app/widgets/big_text.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
          "m.png",
           "x.png",
           "g.png",
    ];
    void _registration(AuthController authController){
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
          showCustomSnackBar("Type in your name",title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number",title: "Phone number");
      }else if(email.isEmpty){
        showCustomSnackBar("Type in your email",title: "Email");
      }else if(GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address",title: "Valid email");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password",title: "password");
      }else if(password.length<6){
        showCustomSnackBar("Password cannot be less than 6 characters",title: "Password");
      }else{
        showCustomSnackBar("All went well",title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
            name: name,
            phone: phone,
            email: email,
            password: password);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            //showCustomSnackBar("All went well",title: "Perfect");
            Get.offNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
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
              //email
              AppTextField(
                  textController: emailController,
                  hintText: "email",
                  icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              //password
              AppTextField(
                  textController: passwordController,
                  hintText: "password",
                  icon: Icons.password_sharp,isObscure: true,),
              SizedBox(height: Dimensions.height20,),
              //name
              AppTextField(
                  textController: nameController,
                  hintText: "name",
                  icon: Icons.person),
              SizedBox(height: Dimensions.height20,),
              //phone
              AppTextField(
                  textController: phoneController,
                  hintText: "phone",
                  icon: Icons.phone),
              SizedBox(height: Dimensions.height20,),

              GestureDetector(
                onTap: (){
                  _registration(_authController);
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
                      text: "Sign up ",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text: "Have an account already?",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.fontSize20
                      )
                  )),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //sign up options
              RichText(
                  text: TextSpan(
                      text: "Sign up using ",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16
                      )
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
              Wrap(
                spacing: MediaQuery.of(context).size.width > 600 ? 32.0 : 16.0,
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage: AssetImage(
                      "assets/image/" + signUpImages[index],
                    ),
                  ),
                )),
              )

            ],
          ),
        ):CustomLoader();
      }),
    );


  }
}
