import 'package:get/get.dart';
import 'package:seller_app/view/v/home_screen/home.dart';
import 'package:seller_app/view/v/product_sceen/component/product_dropdown.dart';
import 'package:seller_app/view/v/product_sceen/component/product_imags.dart';
import 'package:seller_app/view/v/widgets/common_textfild.dart';
import 'package:seller_app/view/v/widgets/loading_design.dart';
import '../../../const/const.dart';
import '../../../controller/products_controller.dart';
import '../widgets/text_style.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: boldText(text: "Add Product", size: 18.0),
        actions: [
         controller.loading.value?LoadingIndicator(color: white): TextButton(
              onPressed: ()async {
                controller.loading(true);
                await controller.uploadImages();
                await controller.uploadProduct(context);
                Get.to(const Home());

              }, child: boldText(text: "Save", size: 16.0))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonTextField(
                    hint: "Eg. BMW",
                    label: "Product Name",
                    controller: controller.pNameController),
                10.heightBox,
                commonTextField(
                    hint: "Eg. Product Details",
                    label: "Product Description",
                    isDesc: true,
                    controller: controller.pDescController),
                10.heightBox,
                commonTextField(
                    hint: "Eg. Price in number",
                    label: "Product Price",
                    controller: controller.pPriceController),
                10.heightBox,
                commonTextField(
                    hint: "Eg. Quantity in number",
                    label: "Product Quantity",
                    controller: controller.pQtyController),
                10.heightBox,
                productDropdown("Category", controller.categoryList,
                    controller.categoryValue, controller),
                10.heightBox,
                productDropdown('Subcategory', controller.subcategoryList,
                    controller.subcategoryValue, controller),
                10.heightBox,
                const Divider(
                  color: white,
                ),
                5.heightBox,
                semiboldText(text: "Chose Images Of Product"),
                5.heightBox,
                semiboldText(text: "1 is Display Image"),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                      3,
                      (index) => controller.pImageList[index] != null
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11),
                                  border: Border.all(color: white)),
                              child: Image.file(
                                controller.pImageList[index],
                                width: 90,height: 90,fit: BoxFit.cover,
                              ).box.padding(const EdgeInsets.all(5)).make(),
                            ).onTap(() {
                              controller.pickImage(index, context);

                      })
                          : productImages(label: "${index + 1}").onTap(() {
                              controller.pickImage(index, context);
                            })),
                ),
                10.heightBox,
                const Divider(color: white),
                semiboldText(text: "Chose Colors Of Your Product"),
                5.heightBox,
                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: List.generate(
                      12,
                      (index) => Stack(
                            alignment: Alignment.center,
                            children: [
                              VxBox()
                                  .color(Vx.randomPrimaryColor)
                                  .roundedFull
                                  .size(60, 60)
                                  .make()
                                  .onTap(() {
                                controller.selectedColorIndex.value = index;
                              }),
                              controller.selectedColorIndex.value == index
                                  ? Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          border: Border.all(
                                              color: purpleColor, width: 3)),
                                      child: const Icon(
                                        Icons.done,
                                        color: white,
                                        size: 30,
                                      ))
                                  : const SizedBox()
                            ],
                          )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
