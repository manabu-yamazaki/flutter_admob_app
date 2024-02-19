import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_admob_app/main.dart';
import 'package:flutter_admob_app/model/contents.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class PointListPage extends StatefulWidget {
  const PointListPage({super.key});

  @override
  State<PointListPage> createState() => _PointListPageState();
}

class _PointListPageState extends State<PointListPage> {
  List<BannerAd> bannerAds = [];
  InterstitialAd? interstitialAd;
  int tapCount = 0;
  bool isLoaded = false;
  List<Contents> contentsList = [
    Contents(title: 'ポイント獲得', imagePath: 'assets/logo.jpeg', point: 1),
    Contents(title: 'ポイントゲット', imagePath: 'assets/logo.jpeg', point: 2),
    Contents(title: 'お得です', imagePath: 'assets/logo.jpeg', point: 3),
    Contents(title: 'ポイント獲得', imagePath: 'assets/logo.jpeg', point: 1),
    Contents(title: 'ポイントゲット', imagePath: 'assets/logo.jpeg', point: 2),
    Contents(title: 'お得です', imagePath: 'assets/logo.jpeg', point: 3),
    Contents(title: 'ポイント獲得', imagePath: 'assets/logo.jpeg', point: 1),
    Contents(title: 'ポイントゲット', imagePath: 'assets/logo.jpeg', point: 2),
    Contents(title: 'お得です', imagePath: 'assets/logo.jpeg', point: 3),
  ];

  void initAd() {
    for (int i = 0; i < contentsList.length ~/ 4; i++){
      BannerAd bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111' : 'ca-app-pub-3940256099942544/2934735716',
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            setState(() {
              isLoaded = true;
            });
          }
        ),
        request: AdRequest()
      )..load();
      bannerAds.add(bannerAd);
    }
    InterstitialAd.load(
      adUnitId: Platform.isAndroid ? 'ca-app-pub-3940256099942544/8691691433' : 'ca-app-pub-3940256099942544/5135589807',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) { interstitialAd= ad; },
        onAdFailedToLoad: (LoadAdError error) { interstitialAd = null; }),
    );
  }

  @override
  void initState() {
    super.initState();
    initAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ポイ活アプリ'),
        actions: [
          Container(
            alignment: Alignment.center, 
            margin: const EdgeInsets.only(right: 20),
            child: Text('$totalPoint', style: const TextStyle(fontSize: 20),),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isMultiply ? Container(
              width: 300,
              height: 50,
              color: Colors.amber,
              alignment: Alignment.center,
              child: const Text('ポイント増量中', style: TextStyle(fontSize: 20, color: Colors.white),),
            ) : Container(),
            buildList(),
          ],
        ),
      ),
    );
  }

  Widget buildList() {
    List<Widget> rowChildren= [];
    List<Widget> columnChildren= [];

    for(int i = 0; i < contentsList.length; i++) {
      rowChildren.add(
        Expanded(
          child: InkWell(
            onTap: () async {
              print('押されたよ');
              setState(() {
                totalPoint += contentsList[i].point * (isMultiply ? 2 : 1);
              });
              if(tapCount < 2) {
                tapCount = tapCount + 1;
              } else {
                await interstitialAd!.show();
                InterstitialAd.load(
                  adUnitId: Platform.isAndroid ? 'ca-app-pub-3940256099942544/8691691433' : 'ca-app-pub-3940256099942544/5135589807',
                  request: const AdRequest(),
                  adLoadCallback: InterstitialAdLoadCallback(
                    onAdLoaded: (InterstitialAd ad) { interstitialAd= ad; },
                    onAdFailedToLoad: (LoadAdError error) { interstitialAd = null; }),
                );
                tapCount = 0;
              }
            },
            child: Card(
              child: Column(
                children: [
                  Image.asset(contentsList[i].imagePath),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(contentsList[i].title),
                        Container(
                          alignment: Alignment.center,
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.amber,
                          ),
                          child: Text(contentsList[i].point.toString()),
                        )
                      ],
                    ),
                  )
                ],
              )
            ),
          )
        )
      );
      if(i % 2 == 1){
        columnChildren.add(Row(children: rowChildren));
        rowChildren = [];
      } else if(i == contentsList.length - 1){
        rowChildren.add(Expanded(child: Container()));
        columnChildren.add(Row(children: rowChildren));
        rowChildren = [];
      }
      if(i % 4 == 3){
        columnChildren.add(
          Container(
            width: bannerAds[i ~/ 4].size.width.toDouble(),
            height: bannerAds[i ~/ 4].size.height.toDouble(),
            child: isLoaded ? AdWidget(ad: bannerAds[i ~/ 4]) : Container(),
          )
        );
      }
    }

    return Column(
      children: columnChildren
    );
  }
}