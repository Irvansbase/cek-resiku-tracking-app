import 'package:cek_resi/utils/rewarded_ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:cek_resi/pages/splash_screen.dart';
import 'package:cek_resi/pages/result_page.dart';
import 'package:cek_resi/models/tracking_result.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  RewardedAdHelper.loadAd(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Cek Resi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SplashScreenWithBanner(),
      routes: {
        '/result': (context) {
          final result =
              ModalRoute.of(context)!.settings.arguments as TrackingResult;
          return ResultPage(result: result);
        },
      },
    );
  }
}

class SplashScreenWithBanner extends StatelessWidget {
  const SplashScreenWithBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Expanded(child: SplashScreen()),
        ],
      ),
    );
  }
}
