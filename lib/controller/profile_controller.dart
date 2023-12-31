import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../const/const.dart';

class ProfileController extends GetxController {
  late QueryDocumentSnapshot snapshotData;
  var profileImagePath = ''.obs;
  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();
  var profileImgLink = '';
  var loading = false.obs;

  var shopNameController = TextEditingController();
  var shopAddressController = TextEditingController();
  var shopWebsiteController = TextEditingController();
  var shopMobileController = TextEditingController();
  var shopDescController = TextEditingController();

  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (img == null) return;
      profileImagePath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var filename = basename(profileImagePath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    profileImgLink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imgUrl}) async {
    var store = firestore.collection(vendorsCollection).doc(currentUser!.uid);
    store.set({'vendors_name': name, 'password': password, 'imageUrl': imgUrl},
        SetOptions(merge: true));
    loading(false);
  }

  updateName({name, imgUrl}) async {
    var store = firestore.collection(vendorsCollection).doc(currentUser!.uid);
    store.set(
        {'vendors_name': name, 'imageUrl': imgUrl}, SetOptions(merge: true));
    loading(false);
  }

  changeAuthPassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword);
    });
  }

  updateShop(
      {shopname, shopmobile, shopwebsite, shopdescription, shopaddress}) async {
    var store = firestore.collection(vendorsCollection).doc(currentUser!.uid);
    store.set({
      'shop_name': shopname,
      'shop_mobile': shopmobile,
      'shop_website': shopwebsite,
      'shop_description': shopdescription,
      'shop_address': shopaddress
    },SetOptions(merge: true));
    loading(false);
  }
}
