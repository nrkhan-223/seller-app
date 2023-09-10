import '../../../const/const.dart';

Widget LoadingIndicator({color = purpleColor}) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(color),
    ),
  );
}
