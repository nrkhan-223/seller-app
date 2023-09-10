import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/services/store_services.dart';
import 'package:seller_app/view/v/messages_screen/chat_screen.dart';
import 'package:seller_app/view/v/widgets/loading_design.dart';
import 'package:intl/intl.dart' as intl;
import '../widgets/text_style.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

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
        title: boldText(text: "Message Screen", size: 18.0),
      ),
      body: StreamBuilder(
          stream: StoreServices.getMessages(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return LoadingIndicator().box.makeCentered();
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                  child: "No Massage".text.semiBold.color(white).make());
            } else {
              var data = snapshot.data!.docs;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                      data.length,
                      (index){
                        var t = data[index]['created_on'] == null ? DateTime.now(): data[index]['created_on'].toDate();
                        var time = intl.DateFormat("h:mma"). format (t);
                        return ListTile(
                          dense: true,
                          leading: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              color: purpleColor,
                            ),
                          ),
                          title: boldText(
                              text: "${data[index]['sender_name']}",
                              size: 17.0),
                          subtitle:
                          normalText(text: "${data[index]['last_msg']}"),
                          trailing: semiboldText(text: time),
                          onTap: () {
                            Get.to(() => const ChatScreen());
                          },
                        );
                      }

                  ),
                ),
              );
            }
          }),
    );
  }
}
