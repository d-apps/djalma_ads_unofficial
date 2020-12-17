import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/widgets.dart';

class Ads {

  // ignore: non_constant_identifier_names
  static String APP_ID = "";
  // ignore: non_constant_identifier_names
  static String BANNER_ID = "";
  // ignore: non_constant_identifier_names
  static String INTERSTITIAL_ID = "";
  // ignore: non_constant_identifier_names
  static String REWARDED_ID = "";
  // ignore: non_constant_identifier_names
  static String NATIVE_ID = "";

  static AdmobBannerSize admobBannerSize;
  static AdmobInterstitial admobInterstitial;
  static AdmobReward admobReward;

  static Future init({List<String> testDevicesIds, String appId = "", String bannerId = "",
    String interstitialId = "", String rewardedId = "", bool reward = false}) async{

    APP_ID = appId.isEmpty?getAppId():appId;
    BANNER_ID = bannerId.isEmpty?getBannerAdUnitId():bannerId;
    INTERSTITIAL_ID = interstitialId.isEmpty?getInterstitialAdUnitId():interstitialId;
    REWARDED_ID = rewardedId.isEmpty?getRewardedAdUnitId():rewardedId;

    // Not a Future
    Admob.initialize(testDeviceIds: testDevicesIds);

    // Set Interstitial Ad
    admobInterstitial = AdmobInterstitial(
        adUnitId: INTERSTITIAL_ID,
        listener: (event, args){

          print("INTERSTITIAL: $event");

          if(event == AdmobAdEvent.closed){
            admobInterstitial.load();
          }

        }
    );

    admobInterstitial.load();

    // Set Reward Ad

    if(reward){

      admobReward = AdmobReward(
          adUnitId: REWARDED_ID,
          listener: (event, args){

            if (event == AdmobAdEvent.closed) admobReward.load();

          }
      );

      admobReward.load();

    }

  }

  static getBannerView(AdmobBannerSize admobBannerSize, BuildContext context){

    return AdmobBanner(
        adUnitId: BANNER_ID,
        adSize: admobBannerSize??AdmobBannerSize.SMART_BANNER(context)
    );

  }

  static Future showInterstitial() async{

    if(await admobInterstitial.isLoaded == false){
      admobInterstitial.load();
    }

    admobInterstitial.show();

  }

  static Future showRewardedAd() async{

    if(await admobReward.isLoaded == false){
      admobReward.load();
    }

    admobReward.show();

  }

  // ==========================

  static getAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544~1458002511';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544~3347511713';
    }

  }

  static getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
  }

  static getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }

  }

  static getRewardedAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    }

  }

  static getNativeAdUnitId() {

    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/2247696110';
    }
  }



}