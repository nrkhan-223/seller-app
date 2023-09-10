import 'package:seller_app/const/const.dart';
import 'package:seller_app/view/v/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

AppBar appbarCommon(title){
  return AppBar(
    backgroundColor: purpleColor,
    automaticallyImplyLeading: false,
    title: semiboldText(text: title, color: white, size: 18.0),
    actions: [
      Center(
          child: normalText(
              text: intl.DateFormat('EEE, MMM d, ' 'yy').format(
                DateTime.now(),
              ),
              color: white)),
      10.widthBox,
    ],
  );
}