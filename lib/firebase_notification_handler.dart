import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationHandler {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    NotificationSettings notificationSettings =
        await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      log('Got a message whilst in the foreground!---- (getInitialMessage) ----');
      log('Message Data: ${message.data}');
      if (message.notification != null) {
        log('Message Notification: ${message.notification}');
        log('Notification Title: ${message.notification?.title ?? 'Empty title'}');
        log('Notification Body: ${message.notification?.body ?? 'Empty body'}');
      }
    }

    //? when app is Foreground, that	means application is open,
    //? in view and in use. At this time Notifications will not appear in the notification tray.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!---- (onMessage) ----');
      log('Message Data: ${message.data}');
      if (message.notification != null) {
        log('Message Notification: ${message.notification}');
        log('Notification Title: ${message.notification?.title ?? 'Empty title'}');
        log('Notification Body: ${message.notification?.body ?? 'Empty body'}');
      }
    });

    //? This code is executed when the notification is already present in the
    //? notification tray and the app is opened with the notification On Tap.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('This App is opened by the Notification Tap ---- (onMessageOpenedApp) ----');
      log('Message Data: ${message.data}');
      if (message.notification != null) {
        log('Message Notification: ${message.notification}');
        log('Notification Title: ${message.notification?.title ?? 'Empty title'}');
        log('Notification Body: ${message.notification?.body ?? 'Empty body'}');
      }
    });

    //? When the app is in the background, meaning the app is not visible. This
    //? code will be executed when notifications appear in the notification tray.
    FirebaseMessaging.onBackgroundMessage(firebaseMessingBackgroundHandler);
  }

  Future<String?> getToken() async {
    return await firebaseMessaging.getToken();
  }

  void onTokenRefresh() async {
    //? when token is refreshed.
    firebaseMessaging.onTokenRefresh.listen((String token) {
      log('Send refresh token to api : $token');
    });
  }

  Future<void> subscribeToTopic(String topicName) async {
    //?  to achieve Topic-Based-Notification, subscribe To Topic.
    await firebaseMessaging.subscribeToTopic(topicName);
  }

  Future<void> unsubscribeFromTopic(String topicName) async {
    //?  Unsubscribe From Topic.
    await firebaseMessaging.unsubscribeFromTopic(topicName);
  }
}

//? Top label function
Future<void> firebaseMessingBackgroundHandler(RemoteMessage message) async {
  log('Top Label Function. ---- (onBackgroundMessage) ----');
  log('Message Data: ${message.data}');
  if (message.notification != null) {
    log('Message Notification: ${message.notification}');
    log('Notification Title: ${message.notification?.title ?? 'Empty title'}');
    log('Notification Body: ${message.notification?.body ?? 'Empty body'}');
  }
}
