import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen(this.result);
  String result;
  RxBool sent = false.obs;

  void _sendSMS(String message, List<String> recipents) async {
    sent.value = false;

    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });

    print(result);
    if (result != null) {
      sent.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final smsMsg = result.toString().substring(11);
    _sendSMS(smsMsg, ['1922']);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Obx(() => !sent.value
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 50,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '已發送',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      smsMsg,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 40),
                    ),
                  ],
                )),
        ),
      ),
    );
  }
}
