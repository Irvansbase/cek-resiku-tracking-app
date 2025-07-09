import 'dart:async';
import 'package:cek_resi/pages/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> const HomePage()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Center(
            child: Hero(tag: "login", child: Image.asset('assets/images/logos.png'), 
            ),
          ),
          CircularProgressIndicator(), // indikator loading
          SizedBox(height: 24),
        ],
      ),
    );
  }
}