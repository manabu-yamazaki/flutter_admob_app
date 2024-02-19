import 'package:flutter/material.dart';
import 'package:flutter_admob_app/pages/top_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const List<String> testDevices = ['YOUR_DEVICE_ID'];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  // MobileAds.instance.updateRequestConfiguration(
  //     RequestConfiguration(testDeviceIds: testDevices));
  runApp(const MyApp());
}

int totalPoint = 0;
bool isMultiply = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TopPage(title: 'Flutter Demo Home Page'),
    );
  }
}

