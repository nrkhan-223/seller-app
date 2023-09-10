import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/view/v/home_screen/home.dart';
import 'package:seller_app/view/v/widgets/common_textfild.dart';
import '../../../controller/profile_controller.dart';
import '../widgets/loading_design.dart';
import '../widgets/text_style.dart';

class ShopSetting extends StatelessWidget {
   const ShopSetting({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
   controller.shopNameController.text=controller.snapshotData['shop_name'];
   controller.shopAddressController.text=controller.snapshotData['shop_address'];
   controller.shopMobileController.text=controller.snapshotData['shop_mobile'];
   controller.shopWebsiteController.text=controller.snapshotData['shop_website'];
   controller.shopDescController.text=controller.snapshotData['shop_description'];
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: "Shop Setting", size: 18.0),
          actions: [
            controller.loading.value
                ? LoadingIndicator(color: white)
                : TextButton(
                    onPressed: () async {
                      controller.loading(true);
                      await controller.updateShop(
                        shopname: controller.shopNameController.text,
                        shopaddress: controller.shopAddressController.text,
                        shopmobile: controller.shopMobileController.text,
                        shopwebsite: controller.shopWebsiteController.text,
                        shopdescription: controller.shopDescController.text,
                      );
                      VxToast.show(context, msg: "Save Changes");
                      Get.offAll(()=>const Home());
                    },
                    child: normalText(text: "Save")),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                commonTextField(
                    label: "Shop Name",
                    hint: "name",
                    controller: controller.shopNameController),
                10.heightBox,
                commonTextField(
                    label: "Shop Address",
                    hint: "Shop Address",
                    controller: controller.shopAddressController),
                10.heightBox,
                commonTextField(
                    label: "Shop Mobile",
                    hint: "Shop Mobile",
                    controller: controller.shopMobileController),
                10.heightBox,
                commonTextField(
                    label: "Shop Website",
                    hint: "Shop Website",
                    controller: controller.shopWebsiteController),
                10.heightBox,
                commonTextField(
                    label: "Shop description",
                    hint: "Shop description",
                    isDesc: true,
                    controller: controller.shopDescController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
