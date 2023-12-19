// Screen class for the first/main screen of this program, where the statuses are displayed and all the functions are initialized
import 'dart:async';

import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';
import '../functions/notification_service.dart';

import '../providers/ble_scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Timer? timer;

  NotificationService notificationServiceFunction = NotificationService();

  Future<void> enableBT() async {
    BluetoothEnable.enableBluetooth.then((String value) {});
  }

  Future<void> startScan() async {
    Provider.of<BleScanner>(context, listen: false).startScan();
  }

  Future<void> getNotificationUpdate() async {
    await notificationServiceFunction.showNotifications();
  }

  Future<void> showNotification() async {
    await notificationServiceFunction.showNotifications();
  }

  @override
  void initState() {
    super.initState();
    enableBT();
    startScan();

    timer = Timer.periodic(
        const Duration(seconds: 5), (Timer t) => getNotificationUpdate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Row(children: <Widget>[
          Text(
            'People Counter BLE',
          ),
          Spacer(),
        ]),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Text('Welcome to People Counter BLE')),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: showNotification,
              child: Text('Show Notification'),
            ),
          ]),
    );
  }
}
