import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_app/controller/orders_controller.dart';
import 'package:seller_app/services/store_services.dart';
import 'package:seller_app/view/v/widgets/apper_bar.dart';
import 'package:intl/intl.dart' as intl;
import 'package:seller_app/view/v/widgets/loading_design.dart';
import '../../../const/const.dart';
import '../widgets/text_style.dart';
import 'order_detaiis.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: appbarCommon("Orders"),
      body: StreamBuilder(
          stream: StoreServices.getOrders(currentUser!.uid),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return LoadingIndicator(color: white).box.makeCentered();
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: semiboldText(text: "No Orders"),
              );
            } else {
              var data = snapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var t = data[index]['order_date'].toDate();
                      var time = intl.  DateFormat.yMMMMd('en_US')   .format(t);
                      return ListTile(

                        onTap: () {
                          Get.to(() =>  OrderDetails(data: data[index],));
                        },
                        dense: true,
                        tileColor: textfieldGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11)),
                        title: boldText(
                            text: "${data[index]['order_code']}",
                            color: fontGrey,
                            size: 17.0),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: darkGrey,
                                ),
                                boldText(text: time, color: purpleColor)
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.payment,
                                  color: darkGrey,
                                ),
                                boldText(text: "Unpaid", color: red)
                              ],
                            )
                          ],
                        ),
                        trailing:currencyText(text: " ${data[index]['total_amount']}",color: purpleColor,size: 16.0)

                      ).box.margin(const EdgeInsets.only(bottom: 5)).make();
                    }),
                  ),
                ),
              );
            }
          }),
    );
  }
}
