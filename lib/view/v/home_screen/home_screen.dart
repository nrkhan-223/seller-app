import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_app/view/v/product_sceen/product_details.dart';
import 'package:seller_app/view/v/widgets/apper_bar.dart';
import 'package:seller_app/view/v/widgets/dashboard_button.dart';
import 'package:seller_app/view/v/widgets/loading_design.dart';
import '../../../const/const.dart';
import '../../../services/store_services.dart';
import '../widgets/text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: appbarCommon("Dashboard"),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return LoadingIndicator(color: white);
          } else {
            var data=snapshot.data!.docs;
           data =data.sortedBy((a, b)=>b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashboardButton(context,
                          title: "products", count: "50", icon: icProducts),
                      dashboardButton(context,
                          title: "Orders", count: "10", icon: icOrders),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashboardButton(context,
                          title: "Rating", count: "50", icon: icStar),
                      dashboardButton(context,
                          title: "Total Sales", count: "10", icon: icSales),
                    ],
                  ),
                  10.heightBox,
                  const Divider(
                    color: Colors.white,
                  ),
                  10.heightBox,
                  boldText(text: "Popular Products", color: white, size: 17.0),
                  20.heightBox,
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
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
                            "\$".text.semiBold.size(18).make(),
                            2.widthBox,
                            "${data[index]['p_price']}"
                                .numCurrency
                                .text
                                .color(Colors.black)
                                .semiBold
                                .size(16)
                                .make()
                          ],
                        ),
                        onTap: () {
                          Get.to(()=>ProductDetails(data: data[index],));
                        },
                      ).box.margin(const EdgeInsets.only(bottom: 5)).make(),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
