import 'package:intl/intl.dart' as intl;
import 'package:seller_app/view/v/widgets/text_style.dart';
import '../../../const/const.dart';

Widget senderBubble() {
  // var t = data['created_on'] == null ? DateTime.now(): data['created_on'].toDate();
  // var time = intl.DateFormat("h:mma"). format (t);
  return Directionality(

    textDirection: TextDirection.ltr,
    child: Container(
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      padding: const EdgeInsets.all(10),
        decoration:  const BoxDecoration(
            color: red,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            )),
       // : const BoxDecoration(
       //      color: red,
       //      borderRadius: BorderRadius.only(
       //        topLeft: Radius.circular(20),
       //        topRight: Radius.circular(20),
       //        bottomRight: Radius.circular(20),
       //      )),
      child:Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         // "${data['msg']}".text.white.size(16).make(),4.heightBox,
          semiboldText(text: "fiopifhaofhf"),
          10.heightBox,
         // time.text.color(Colors.white.withOpacity(0.5)).size(10).make()
          normalText(text: "10:00 PM")
        ],
      )
    ),
  );
}
