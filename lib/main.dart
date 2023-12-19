import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'functions/notification_service.dart';
import 'providers/ble_logger.dart';
import 'providers/ble_scanner.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService().init(); // <----

  final FlutterReactiveBle ble = FlutterReactiveBle();
  final BleLogger bleLogger = BleLogger(ble: ble);

  final BleScanner scanner =
      BleScanner(ble: ble, logMessage: bleLogger.addToLog);

  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        Provider<BleScanner>.value(value: scanner),
        Provider<BleLogger>.value(value: bleLogger),
        StreamProvider<BleScannerState?>(
          create: (_) => scanner.state,
          initialData: const BleScannerState(
            discoveredDevices: <DiscoveredDevice>[],
            scanIsInProgress: false,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Reactive BLE example',
        color: Colors.transparent,
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    ),
  );
}
