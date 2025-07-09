import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeExample extends StatefulWidget {
  const NativeExample({super.key});

  @override
  State<NativeExample> createState() => NativeExampleState();
}

class NativeExampleState extends State<NativeExample> {
  NativeAd? nativeAd;
  bool _nativeAdIsLoaded = false;

  final String _adUnitId = ''; //Real Andri Irvansyah

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }

  void loadAd() {
    nativeAd = NativeAd(
      adUnitId: _adUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() => _nativeAdIsLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: Colors.grey[200]!,
        cornerRadius: 12.0,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white,
          backgroundColor: Colors.blue,
          style: NativeTemplateFontStyle.bold,
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black,
          backgroundColor: Colors.transparent,
          style: NativeTemplateFontStyle.normal,
          size: 18.0,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.grey,
          backgroundColor: Colors.transparent,
          style: NativeTemplateFontStyle.italic,
          size: 14.0,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.grey[600]!,
          backgroundColor: Colors.transparent,
          style: NativeTemplateFontStyle.normal,
          size: 12.0,
        ),
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return _nativeAdIsLoaded
        ? Container(
            height: 300, // Tinggi yang direkomendasikan untuk native ad
            padding: const EdgeInsets.all(8),
            child: AdWidget(ad: nativeAd!),
          )
        : const Center(child: CircularProgressIndicator());
  }
}