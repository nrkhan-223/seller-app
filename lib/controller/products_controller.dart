import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app/const/const.dart';
import '../models/category_model.dart';
import 'home_controller.dart';

class ProductsController extends GetxController {
  var pNameController = TextEditingController();
  var pPriceController = TextEditingController();
  var pDescController = TextEditingController();
  var pQtyController = TextEditingController();
  var loading = false.obs;

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;

  List<Category> category = [];
  var pImageList = RxList<dynamic>.generate(3, (index) => null);
  var pImagesLink = [];

  var categoryValue = ''.obs;
  var subcategoryValue = ''.obs;
  var selectedColorIndex = 0.obs;

  getCategories() async {
    var data =
        await rootBundle.loadString(("lib/services/category_model.json"));
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  generateCategoryList() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  generateSubCategoryList(cat) {
    subcategoryList.clear();
    var data = category.where((element) => element.name == cat).toList();
    for (var i = 0; i < data.first.subcategory.length; i++) {
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) {
        return;
      } else {
        pImageList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImages() async {
    pImagesLink.clear();
    for (var item in pImageList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination = 'images/vendors/${currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pImagesLink.add(n);
      }
    }
  }

  uploadProduct(context) async {
    var store = firestore.collection(productCollection).doc();
    await store.set({
      'is_featured': false,
      'p_category': categoryValue.value,
      'p_colors': FieldValue.arrayUnion([Colors.red.value, Colors.green.value]),
      'p_descriptions': pDescController.text,
      'p_img': FieldValue.arrayUnion(pImagesLink),
      'p_name': pNameController.text,
      'p_price': pPriceController.text,
      'p_quantity': pQtyController.text,
      'p_subcategory': subcategoryValue.value,
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_seller': Get.find<HomeController>().username,
      'p_rating': "5.0",
      'vendor_id': currentUser!.uid,
      'feature_id': ''
    });
    loading(false);
    VxToast.show(context, msg: "Product Uploaded");
  }

  addFeature(id) async {
    await firestore.collection(productCollection).doc(id).set({
      'feature_id': currentUser!.uid,
      'is_featured': true,
    }, SetOptions(merge: true));
  }

  removeFeature(id) async {
   await firestore.collection(productCollection).doc(id).set({
      'feature_id': '',
      'is_featured': false,
    }, SetOptions(merge: true));
  }

  removeProduct(id)async{
    await firestore.collection(productCollection).doc(id).delete();
  }
}
