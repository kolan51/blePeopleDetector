// Screen class for the first/main screen of this program, where the statuses are displayed and all the functions are initialized
import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();

  Future<void> enableBT() async {
    BluetoothEnable.enableBluetooth.then((String value) {});
  }

  @override
  void initState() {
    super.initState();
    enableBT();
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
      body: const Column(
          children: <Widget>[Text('Welcome to People Counter BLE')]),
    );
  }
}
