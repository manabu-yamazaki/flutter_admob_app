import 'package:flutter/material.dart';
import 'package:flutter_admob_app/main.dart';

class WatchVideoPage extends StatefulWidget {
  const WatchVideoPage({super.key});

  @override
  State<WatchVideoPage> createState() => _WatchVideoPageState();
}

class _WatchVideoPageState extends State<WatchVideoPage> {
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
                onPressed: () {
                  setState(() {
                    totalPoint += 5;
                  });
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
                onPressed: () {
                  setState(() {
                    isMultiply = true;
                  });
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