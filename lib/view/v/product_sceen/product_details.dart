import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import '../widgets/text_style.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key,this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: boldText(text: "${data['p_name']}", size: 18.0),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VxSwiper.builder(
                      enlargeCenterPage: true,
                      height: 350,
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      viewportFraction: 0.9,
                      itemCount: data['p_img'].length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          data['p_img'][index],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ).box.roundedSM.clip(Clip.antiAlias).make();
                      }),
                  15.heightBox,

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "${data['p_name']}".text.bold.size(22).color(white).make(),
                        10.heightBox,
                        Row(
                          children: [
                            boldText(text: "${data['p_category']},",size: 16.0,),2.widthBox,
                            boldText(text: "${data['p_subcategory']}",size: 16.0,),
                          ],
                        ),10.heightBox,
                        VxRating(
                          isSelectable: false,
                          value: double.parse(data['p_rating']),
                          onRatingUpdate: (value) {},
                          normalColor: textfieldGrey,
                          selectionColor: golden,
                          size: 25,
                          maxRating: 5,
                          count: 5,
                        ),
                        10.heightBox,
                        Row(
                          children: [
                            "\$".text.semiBold.size(18).color(red).make(),
                            2.widthBox,
                            "${data['p_price']}".numCurrency
                                .text
                                .color(white)
                                .bold
                                .size(18)
                                .make()
                          ],
                        ),
                        10.heightBox,
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Color: ".text.color(purpleColor).make(),
                                ),
                                Row(
                                    children: List.generate(
                                      data['p_colors'].length,
                                          (index) => VxBox()
                                          .size(40, 40)
                                          .roundedFull
                                          .color(Color(data['p_colors'][index]))
                                          .margin(
                                          const EdgeInsets.symmetric(horizontal: 3))
                                          .make()
                                          .onTap(() {}),
                                    ))
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quality: ".text.color(purpleColor).make(),
                                ),
                                semiboldText(text: "${data['p_quantity']} item",color: purpleColor)
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                          ],
                        )
                            .box
                            .white
                            .roundedSM
                        .padding(const EdgeInsets.all(5))
                            .shadowSm
                            .make(),
                        const Divider(color: white,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Description"
                                  .text
                                  .size(18)
                                  .bold
                                  .color(white)
                                  .make(),
                              10.heightBox,
                              "${data['p_descriptions']} "
                                  .text
                                  .size(14.5)
                                  .semiBold
                                  .color(white)
                                  .make(),
                              10.heightBox,
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
