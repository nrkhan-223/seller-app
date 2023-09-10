import 'dart:io';
import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/controller/profile_controller.dart';
import '../home_screen/home.dart';
import '../widgets/common_textfild.dart';
import '../widgets/loading_design.dart';
import '../widgets/text_style.dart';

class EditProfile extends StatefulWidget {
  final String? userame;

  const EditProfile({super.key, this.userame});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    controller.nameController.text = widget.userame!;
  }


  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: "Edit Profile", size: 18.0),
          actions: [
            controller.loading.value
                ? LoadingIndicator(color: white)
                : TextButton(
                    onPressed: () async {
                      controller.loading(true);
                      if (controller.profileImagePath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImgLink =
                            controller.snapshotData['imageUrl'];
                      }
                      if (controller.nameController.text.isNotEmpty &&
                          controller.newpassController.text.isEmpty &&
                          controller.oldpassController.text.isEmpty) {
                        await controller
                            .updateName(
                                name: controller.nameController.text,
                                imgUrl: controller.profileImgLink)
                            .then((value) {
                          VxToast.show(context, msg: "Successfully changed");
                          Get.offAll(()=>const Home());
                        });
                      } else if (controller.nameController.text.isEmpty &&
                          controller.newpassController.text.isNotEmpty &&
                          controller.oldpassController.text.isNotEmpty) {
                        if (controller.snapshotData['password'] ==
                            controller.oldpassController.text) {
                          await controller.changeAuthPassword(
                              email: controller.snapshotData['email'],
                              password: controller.oldpassController.text,
                              newpassword: controller.newpassController.text);

                          await controller
                              .updateProfile(
                                  name: controller.nameController.text,
                                  password: controller.snapshotData['password'],
                                  imgUrl: controller.profileImgLink)
                              .then((value) {
                            VxToast.show(context, msg: "Successfully changed");
                            Get.offAll(()=>const Home());
                          });
                        } else {
                          VxToast.show(context, msg: "Wrong Password");
                          controller.loading(false);
                        }
                      }
                    },
                    child: normalText(text: "Save")),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              20.heightBox,
              controller.snapshotData['imageUrl'] == '' &&
                      controller.profileImagePath.isEmpty
                  ? Image.asset(
                      icProduct,
                      width: 70,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : controller.snapshotData['imageUrl'] != '' &&
                          controller.profileImagePath.isEmpty
                      ? Image.network(
                          controller.snapshotData['imageUrl'],
                          width: 70,
                          fit: BoxFit.cover,
                        ).box.clip(Clip.antiAlias).roundedFull.make()
                      : Image.file(
                          File(controller.profileImagePath.value),
                          width: 70,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ElevatedButton(
                onPressed: () {
                  controller.changeImage(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: semiboldText(text: "Change Image", color: darkGrey),
              ),
              10.heightBox,
              const Divider(),
              10.heightBox,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    boldText(text: "Change Name"),
                    5.heightBox,
                    commonTextField(
                        label: "Name",
                        hint: "Seller Name",
                        controller: controller.nameController),
                    20.heightBox,
                    boldText(text: "Change Password"),
                    5.heightBox,
                    commonTextField(
                        label: "Old Password",
                        hint: "Old Password",
                        controller: controller.oldpassController),
                    10.heightBox,
                    commonTextField(
                        label: "New Password",
                        hint: "New Password",
                        controller: controller.newpassController)
                  ],
                ),
              ),
            ],
          ).box.height(context.screenHeight - 20).make(),
        ),
      ),
    );
  }
}
