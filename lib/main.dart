import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'providers/ble_logger.dart';
import 'providers/ble_scanner.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final FlutterReactiveBle _ble = FlutterReactiveBle();
  final BleLogger bleLogger = BleLogger(ble: _ble);

  final BleScanner scanner =
      BleScanner(ble: _ble, logMessage: bleLogger.addToLog);

  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        Provider.value(value: scanner),
        Provider.value(value: bleLogger),
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
        home: const HomeScreen(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      color: Colors.transparent,
      debugShowCheckedModeBanner: false,
      title: 'Nearby People Counter',
      home: HomeScreen(),
    );
  }
}
