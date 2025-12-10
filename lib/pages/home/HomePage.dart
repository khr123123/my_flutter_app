import 'package:flutter/material.dart';
import 'package:my_app/pages/cart/CartPage.dart';
import 'package:my_app/pages/category/CategoryPage.dart';
import 'package:my_app/pages/home/components/Category.dart';
import 'package:my_app/pages/home/components/Hot.dart';
import 'package:my_app/pages/home/components/More.dart';
import 'package:my_app/pages/home/components/Slider.dart';
import 'package:my_app/pages/home/components/Suggestion.dart';
import 'package:my_app/pages/my/MyPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _tabList = [
    {"title": "ホーム", "icon": Icons.home_outlined, "activeIcon": Icons.home},
    {
      "title": "お気に入り",
      "icon": Icons.favorite_outline,
      "activeIcon": Icons.favorite,
    },
    {"title": "会員証", "icon": Icons.person_outline, "activeIcon": Icons.person},
    {"title": "カテゴリ", "icon": Icons.menu, "activeIcon": Icons.menu},
  ];

  final List<Widget> _pages = [
    SingleChildScrollView(
      child: Column(
        children: [
          // 轮播图组件
          SliderSection(),
          SizedBox(height: 10),

          // 分类组件
          CategorySection(),
          SizedBox(height: 10),

          // 热门商品组件
          HotSection(),
          SizedBox(height: 10),

          // 推荐商品组件
          SuggestionSection(),
          SizedBox(height: 10),

          // 更多商品组件
          MoreSection(),
          SizedBox(height: 20),
        ],
      ),
    ),
    CartPage(),
    CategoryPage(),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          iconSize: 32,
          selectedFontSize: 16,
          unselectedFontSize: 16,

          items: _tabList
              .map(
                (e) => BottomNavigationBarItem(
                  icon: Icon(e["icon"]),
                  activeIcon: Icon(e["activeIcon"]),
                  label: e["title"],
                ),
              )
              .toList(),

          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
