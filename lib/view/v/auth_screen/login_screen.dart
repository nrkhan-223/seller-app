import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/controller/auth_controller.dart';
import 'package:seller_app/view/v/home_screen/home.dart';
import '../widgets/common_button.dart';
import '../widgets/text_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.heightBox,
            normalText(text: welcome, size: 18.0),
            20.heightBox,
            Row(
              children: [
                Image.asset(
                  icLogo,
                  width: 70,
                  height: 70,
                )
                    .box
                    .border(color: Colors.white)
                    .rounded
                    .padding(const EdgeInsets.all(8))
                    .make(),
                10.widthBox,
                boldText(text: appname, size: 20.0),
              ],
            ),
            50.heightBox,
            semiboldText(text: "Login To Your Account...",size: 18.0,color: lightGrey),
            10.heightBox,
            Obx(
              ()=> Column(
                children: [
                  TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: purpleColor,
                        ),
                        border: InputBorder.none,
                        hintText: "Enter Your Email..."),
                  ),
                  10.heightBox,
                  TextFormField(
                    controller: controller.passwordController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: purpleColor,
                        ),
                        border: InputBorder.none,
                        hintText: "Enter Your Password..."),
                  ),
                  10.heightBox,
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: normalText(
                              text: "Forget Password", color: purpleColor))),
                  15.heightBox,
                  controller.isLoading.value?const CircularProgressIndicator(
                    valueColor:  AlwaysStoppedAnimation(red),
                  ):commonButton(title: "Login", onPress: () async {
                    controller.isLoading.value=true;
                    await controller.loginMethod(context).then((value){
                      if(value!=null){
                        Get.offAll(()=>const Home());
                        controller.isLoading(false);
                        controller.emailController.clear();
                        controller.passwordController.clear();
                        VxToast.show(context, msg: "login successfully");
                      }else{
                        controller.isLoading(false);
                       VxToast.show(context, msg: "Error Email Or Password");
                      }
                    });
                  }).box.width(context.screenWidth - 50).make(),
                ],
              )
                  .box
                  .white
                  .rounded
                  .outerShadowMd
                  .padding(const EdgeInsets.all(8))
                  .make(),
            ),
            20.heightBox,
            Center(child: normalText(text: anyProblem,color: lightGrey)),
            const Spacer(),
            Center(child: boldText(text: credit,color: lightGrey)),
            10.heightBox,
          ],
        ),
      ),
    );
  }
}
