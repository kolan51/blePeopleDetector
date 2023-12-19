import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final AndroidNotificationDetails _androidNotificationDetails =
      const AndroidNotificationDetails(
    'channel ID',
    'channel name',
    priority: Priority.high,
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotifications() async {
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: _androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        12345,
        'A Notification From My Application',
        'This notification was sent using Flutter Local Notifcations Package',
        platformChannelSpecifics,
        payload: 'data');
  }
}
