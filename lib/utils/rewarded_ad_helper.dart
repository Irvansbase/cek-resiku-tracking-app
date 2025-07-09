import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdHelper {
  static RewardedAd? _rewardedAd;
  static bool _isAdLoaded = false;

  static void loadAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-1994410338990902/5202990051', // Ganti dengan ID Anda
      // Untuk testing: 'ca-app-pub-3940256099942544/5224354917'
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isAdLoaded = true;
        },
        onAdFailedToLoad: (error) {
          _isAdLoaded = false;
        },
      ),
    );
  }

  static void showAd({
    required Function() onAdDismissed,
    required Function(String) onAdFailed,
  }) {
    if (!_isAdLoaded || _rewardedAd == null) {
      onAdFailed('Iklan belum siap');
      return;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        loadAd(); // Muat iklan berikutnya
        onAdDismissed();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        loadAd();
        onAdFailed(error.message);
      },
    );

    _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {},
    );
    _rewardedAd = null;
    _isAdLoaded = false;
  }
}