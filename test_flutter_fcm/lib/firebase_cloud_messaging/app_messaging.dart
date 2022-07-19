import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AppMessaging {
  void setup() {
    _registerToken();
    _requestUserPermission();
  }

  void _registerToken() async {
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

  void _requestUserPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint('User granted permission: ${settings.authorizationStatus}');
  }
}
