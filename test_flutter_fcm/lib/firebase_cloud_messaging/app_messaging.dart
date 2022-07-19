import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AppMessaging {
  void setup() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
      debugPrint('FCM token update to: $fcmToken');
    }).onError((err) {
      // Error getting token.
    });
    debugPrint('FCM token is: $fcmToken');
  }
}
