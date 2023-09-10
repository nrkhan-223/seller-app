import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_app/controller/profile_controller.dart';
import 'package:seller_app/services/store_services.dart';
import 'package:seller_app/view/v/messages_screen/message_screen.dart';
import 'package:seller_app/view/v/profile_screen/edit_profile.dart';
import 'package:seller_app/view/v/shop_setting/shop_setting.dart';
import 'package:seller_app/view/v/widgets/loading_design.dart';
import 'package:seller_app/view/v/widgets/text_style.dart';
import '../../../const/const.dart';
import '../../../controller/auth_controller.dart';
import '../auth_screen/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: "Setting", size: 18.0),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(
                    () => EditProfile(
                      userame: controller.snapshotData['vendors_name'],
                    ),
                  );
                },
                icon: const Icon(Icons.edit)),
            TextButton(
                onPressed: () async {
                  await Get.put(AuthController()).signOutMethod(context);
                  VxToast.show(context, msg: "logout successfully");
                  Get.offAll(() => const LoginScreen());
                },
                child: normalText(text: "Logout")),
          ],
        ),
        body: FutureBuilder(
            future: StoreServices.getProfile(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return LoadingIndicator(color: white).box.makeCentered();
              } else {
                controller.snapshotData = snapshot.data!.docs[0];
                return Column(
                  children: [
                    20.heightBox,
                    ListTile(
                      leading: controller.snapshotData['imageUrl'] == ''
                          ? Image.asset(
                              icProduct,
                              width: 70,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.network(
                              controller.snapshotData['imageUrl'],
                              width: 60,
                              fit: BoxFit.cover,
                            ).box.clip(Clip.antiAlias).roundedFull.make(),
                      title: boldText(
                          text: "${controller.snapshotData['vendors_name']}"),
                      subtitle: normalText(
                          text: "${controller.snapshotData['email']}"),
                    ),
                    10.heightBox,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: List.generate(
                            profileButtonsTitle.length,
                            (index) => ListTile(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Get.to(() =>  const ShopSetting(
                                        ));
                                        break;
                                      case 1:
                                        Get.to(() => const MessageScreen());
                                    }
                                  },
                                  leading: Icon(
                                    profileButtonsIcons[index],
                                    color: Colors.white,
                                  ),
                                  title: semiboldText(
                                      text: profileButtonsTitle[index]),
                                )),
                      ),
                    )
                  ],
                );
              }
            }));
  }
}
