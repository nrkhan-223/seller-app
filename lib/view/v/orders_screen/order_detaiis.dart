import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/controller/orders_controller.dart';
import 'package:seller_app/view/v/widgets/common_button.dart';
import '../widgets/text_style.dart';
import 'components/order_place_details.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatefulWidget {
  final dynamic data;

  const OrderDetails({super.key, this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.find<OrdersController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getOrders(widget.data);
    controller.confirm.value = widget.data['order_confirmed'];
    controller.placed.value = widget.data['order_place'];
    controller.on_delivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: boldText(text: "Order screen", size: 18.0),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              boldText(
                text: "Order Status",
                size: 15.0,
              ),
              10.heightBox,
              Visibility(
                visible: controller.confirm.value,
                child: Column(
                  children: [
                    SwitchListTile(
                      value: controller.confirm.value,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        controller.confirm.value = value;
                      },
                      title: boldText(text: "Confirm", color: purpleColor),
                    ),
                    const Divider(
                      color: purpleColor,
                    ),
                    SwitchListTile(
                      value: controller.placed.value,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        controller.placed.value = value;
                        controller.changeStatus(
                            status: value,
                            title: "order_place",
                            docId: widget.data.id);
                      },
                      title: boldText(text: "Placed", color: purpleColor),
                    ),
                    const Divider(
                      color: purpleColor,
                    ),
                    SwitchListTile(
                      value: controller.on_delivery.value,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        controller.on_delivery.value = value;
                        controller.changeStatus(
                            status: value,
                            title: "order_on_delivery",
                            docId: widget.data.id);
                      },
                      title: boldText(text: "On Delivery", color: purpleColor),
                    ),
                    const Divider(
                      color: purpleColor,
                    ),
                    SwitchListTile(
                      value: controller.delivered.value,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        controller.delivered.value = value;
                        controller.changeStatus(
                            status: value,
                            title: "order_delivered",
                            docId: widget.data.id);
                      },
                      title: boldText(text: "Delivered", color: purpleColor),
                    ),
                  ],
                )
                    .box
                    .roundedSM
                    .color(lightGrey)
                    .margin(const EdgeInsets.symmetric(horizontal: 10))
                    .make(),
              ),
              10.heightBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    orderPlaceDetails(
                        d1: "${widget.data['order_code']}",
                        d2: " ${widget.data['shipping_method']}",
                        title1: "Order Code",
                        title2: "Shipping Method"),
                    orderPlaceDetails(
                        d1: intl.DateFormat()
                            .add_yMd()
                            .format((widget.data['order_date'].toDate())),
                        d2: "${widget.data['payment_method']}",
                        title1: "Order Date",
                        title2: "Payment Method"),
                    orderPlaceDetails(
                        d1: "UnPaid",
                        d2: "OrderPlaced",
                        title1: "Payment Status",
                        title2: "Delivery Status"),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Shipping Address".text.semiBold.make(),
                              2.heightBox,
                              "${widget.data['order_by_name']}".text.make(),
                              "${widget.data['order_by_email']}".text.make(),
                              "${widget.data['order_by_address']}".text.make(),
                              "${widget.data['order_by_city']}".text.make(),
                              "${widget.data['order_by_state']}".text.make(),
                              "${widget.data['order_by_phone']}".text.make(),
                              "${widget.data['order_by_postal']}".text.make()
                            ],
                          ),
                          SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Total Amount".text.semiBold.make(),
                                20.heightBox,
                                Row(
                                  children: [
                                    "\$".text.color(red).bold.make(),
                                    "${widget.data['total_amount']}"
                                        .text
                                        .bold
                                        .color(red)
                                        .make()
                                  ],
                                ),
                                76.heightBox,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.heightBox,
                  ],
                ).box.roundedSM.color(lightGrey).make(),
              ),
              const Divider(),
              10.heightBox,
              "Order Product".text.semiBold.color(Colors.white).size(15).make(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(controller.orders.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  "${controller.orders[index]['img']}",
                                  width: 70,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                "${controller.orders[index]['title']}"
                                    .text
                                    .semiBold
                                    .color(white)
                                    .make(),
                                3.heightBox,
                                Row(
                                  children: [
                                    "${controller.orders[index]['qty']}X"
                                        .text
                                        .semiBold
                                        .color(Colors.red)
                                        .make(),
                                    5.widthBox,
                                    Container(
                                      height: 15,
                                      width: 15,
                                      color: Color(
                                          controller.orders[index]['color']),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              width: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      "\$".text.color(red).bold.make(),
                                      "${controller.orders[index]['tprice']}"
                                          .numCurrency
                                          .text
                                          .semiBold
                                          .color(white)
                                          .make(),
                                    ],
                                  ),
                                  3.heightBox,
                                  "Refundable"
                                      .text
                                      .semiBold
                                      .color(Colors.red)
                                      .make(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: white,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ).box.color(purpleColor).make(),
            ],
          ),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirm.value,
          child: SizedBox(
            height: 55,
            width: context.screenWidth,
            child: commonButton(
                color: green,
                title: "Confirm",
                onPress: () {
                  controller.confirm(true);
                  controller.changeStatus(
                      status: true,
                      title: "order_confirmed",
                      docId: widget.data.id);
                }),
          ),
        ),
      ),
    );
  }
}
