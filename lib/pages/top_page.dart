
import 'package:flutter/material.dart';
import 'package:flutter_admob_app/model/button_navigation.dart';
import 'package:flutter_admob_app/pages/point_list_page.dart';
import 'package:flutter_admob_app/pages/watch_video_page.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key, required this.title});

  final String title;

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<ButtonNavigationEntity> navigationList = [
    ButtonNavigationEntity(title: 'ポイント獲得', icon: Icons.control_point_duplicate, page: const PointListPage()),
    ButtonNavigationEntity(title: 'ブースト', icon: Icons.trending_up, page: const WatchVideoPage()),
  ];
  int selectedIndex = 0;

  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationList[selectedIndex].page,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });
        },
        items: navigationList.map((item) => BottomNavigationBarItem(
          icon: Icon(item.icon),
          label: item.title,
          )).toList(),
      ),
    );
  }
}