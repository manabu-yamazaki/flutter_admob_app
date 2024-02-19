import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_admob_app/main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class WatchVideoPage extends StatefulWidget {
  const WatchVideoPage({super.key});

  @override
  State<WatchVideoPage> createState() => _WatchVideoPageState();
}

class _WatchVideoPageState extends State<WatchVideoPage> {
  RewardedAd? rewardedAd;
  bool isLoaded = false;

  void initAd() {
    createRewardedAd();
  }

  void createRewardedAd() {
    RewardedAd.load(
      adUnitId: Platform.isAndroid ? 'ca-app-pub-3940256099942544/5224354917' : 'ca-app-pub-3940256099942544/1712485313',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
          setState(() {
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          rewardedAd = null;
        }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ポイ活アプリ'),
        actions: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 20),
            child: Text('$totalPoint', style: const TextStyle(fontSize: 20),),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('5ポイント獲得', style: TextStyle(fontSize: 20),),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if(isLoaded){
                    await rewardedAd!.show(
                      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
                        setState(() {
                          totalPoint += 5;
                        });
                      }
                    );
                    createRewardedAd();
                  }
                },
                child: const Text('動画視聴', style: TextStyle(fontSize: 20),)
              ),
            ),
            const Padding(padding: EdgeInsets.all(20)),
            const Text('獲得ポイントを2倍に', style: TextStyle(fontSize: 20),),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if(isLoaded){
                    await rewardedAd!.show(
                      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
                        setState(() {
                          isMultiply = true;
                        });
                      }
                    );
                    createRewardedAd();
                  }
                },
                child: const Text('動画視聴', style: TextStyle(fontSize: 20),)
              ),
            )
          ]
        ),
      ),
    );
  }
}