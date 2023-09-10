import 'package:seller_app/view/v/widgets/text_style.dart';
import '../../../const/const.dart';

Widget dashboardButton(context,{title,count,icon}) {
  var size= MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            semiboldText(text: title, size: 16.0,color: purpleColor),
            semiboldText(text: count, size: 20.0,color: purpleColor),

          ],
        ),
      ),
      Image.asset(icon, width: 40, color:purpleColor,)
    ],
  ).box
      .color(textfieldGrey)
      .rounded
      .size(size.width * .41, 80)
      .padding(const EdgeInsets.all(8))
      .make();
}