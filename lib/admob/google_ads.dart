import 'package:bmi_calculator/const/const.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAds {
  static InterstitialAd? interstitialAd;
  static BannerAd? bannerAd;

  static Future<void> loadInterstitialAd({bool showAfterLoad = false}) async {
    await InterstitialAd.load(
        adUnitId: Const.adUnitIdInterstitial,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            interstitialAd = ad;
            if (showAfterLoad) {
              showInstertitialAd();
            }
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  static void showInstertitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.show();
    } else {}
  }

  static Future<void> loadBannerAd({required VoidCallback onAdLoaded}) async {
    bannerAd = await BannerAd(
      adUnitId: Const.adUnitIdBanner,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print(ad.toString() + "asddddddddddddddddddddddd");
          bannerAd = ad as BannerAd;
          onAdLoaded();
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('dWidget requires Ad.load to be cal led before AdWidget is inserted into the: ${err.message}');
          ad.dispose();
        },
      ),
    )
      ..load();
  }
}
