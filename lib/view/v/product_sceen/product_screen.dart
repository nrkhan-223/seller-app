import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_app/controller/products_controller.dart';
import 'package:seller_app/services/store_services.dart';
import 'package:seller_app/view/v/product_sceen/add_product.dart';
import 'package:seller_app/view/v/product_sceen/product_details.dart';
import 'package:seller_app/view/v/widgets/apper_bar.dart';
import '../../../const/const.dart';
import '../widgets/loading_design.dart';
import '../widgets/text_style.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    return Scaffold(
        backgroundColor: purpleColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: purpleColor,
          child: const Icon(Icons.add),
          onPressed: () async {
            await controller.getCategories();
            controller.generateCategoryList();
            Get.to(() => const AddProduct());
          },
        ),
        appBar: appbarCommon("Products"),
        body: StreamBuilder(
            stream: StoreServices.getProducts(currentUser!.uid),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: LoadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                    child:
                        "No Massage".text.semiBold.color(Colors.white).make());
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(
                        data.length,
                        (index) => ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11)),
                          tileColor: textfieldGrey,
                          leading: Image.network(
                            data[index]['p_img'][0],
                            width: 100,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                          title: boldText(
                              text: "${data[index]['p_name']}",
                              color: purpleColor,
                              size: 17.0),
                          subtitle: Row(
                            children: [
                              Row(
                                children: [
                                  "\$".text.semiBold.size(18).make(),
                                  2.widthBox,
                                  "${data[index]['p_price']}"
                                      .numCurrency
                                      .text
                                      .color(Colors.black)
                                      .semiBold
                                      .size(18)
                                      .make()
                                ],
                              ),
                              10.widthBox,
                              boldText(
                                  text: data[index]['is_featured'] == true
                                      ? "Featured"
                                      : '',
                                  color: green),
                            ],
                          ),
                          onTap: () {
                            Get.to(() => ProductDetails(
                                  data: data[index],
                                ));
                          },
                          trailing: VxPopupMenu(
                            arrowSize: 15,
                            arrowColor: purpleColor,
                            menuBuilder: () => Column(
                              children: List.generate(
                                  popupMenu.length,
                                  (i) => Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            Icon(
                                              popupMenuIcon[i],
                                              color: data[index]
                                                              ['feature_id'] ==
                                                          currentUser!.uid &&
                                                      i == 0
                                                  ? Colors.green
                                                  : Colors.white,
                                            ),
                                            20.widthBox,
                                            normalText(
                                                text:
                                                    data[index]['feature_id'] ==
                                                                currentUser!
                                                                    .uid &&
                                                            i == 0
                                                        ? 'Remove Feature'
                                                        : popupMenu[i],
                                                color: white)
                                          ],
                                        ).onTap(() {
                                          switch (i) {
                                            case 0:
                                              if (data[index]['is_featured'] ==
                                                  true) {
                                                controller.removeFeature(
                                                    data[index].id);
                                              } else {
                                                controller
                                                    .addFeature(data[index].id);
                                              }

                                              break;
                                            case 1:
                                              break;
                                            case 2:
                                              controller.removeProduct(
                                                  data[index].id);
                                              VxToast.show(context,
                                                  msg:
                                                      "Product has been remove");
                                              break;
                                          }
                                        }),
                                      )),
                            )
                                .box
                                .color(purpleColor)
                                .width(210)
                                .padding(const EdgeInsets.all(6))
                                .rounded
                                .make(),
                            clickType: VxClickType.singleClick,
                            child: const Icon(Icons.more_vert_rounded),
                          ),
                        ).box.margin(const EdgeInsets.only(bottom: 5)).make(),
                      ),
                    ),
                  ),
                );
              }
            }));
  }
}
