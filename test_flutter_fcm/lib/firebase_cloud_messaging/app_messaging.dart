import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AppMessaging {
  static final AppMessaging _instance = AppMessaging();
  static AppMessaging get instance => _instance;

  String? fcmToken;
  Future<void> setup() async {
    await _requestUserPermission();
    fcmToken = await FirebaseMessaging.instance.getToken();
    _onTokenRefresh();
    _onListenForegroundMessage();
  }

  void _onTokenRefresh() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
      this.fcmToken = fcmToken;
      debugPrint('FCM token update to: $fcmToken');
    }).onError((err) {
      // Error getting token.
    });
    debugPrint('FCM token is: $fcmToken');
  }

  Future<void> _requestUserPermission() async {
    final settings = await FirebaseMessaging.instance.requestPermission(
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

  void _onListenForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');

      // TODO: check message.data if messageType will be data in later
      if (message.notification != null) {
        debugPrint(
            'Message also contained a notification: ${message.notification}');
      }
    });
  }
}
