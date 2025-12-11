import 'package:flutter/material.dart';
import 'package:my_app/api/HomeApi.dart';
import 'package:my_app/pages/cart/CartPage.dart';
import 'package:my_app/pages/category/CategoryPage.dart';
import 'package:my_app/pages/home/components/Category.dart';
import 'package:my_app/pages/home/components/Hot.dart';
import 'package:my_app/pages/home/components/More.dart';
import 'package:my_app/pages/home/components/Slider.dart';
import 'package:my_app/pages/home/components/Suggestion.dart';
import 'package:my_app/pages/my/MyPage.dart';
import 'package:my_app/viewmodels/BannerItem.dart';
import 'package:my_app/viewmodels/CategoryItem.dart';
import 'package:my_app/viewmodels/Recommend.dart';
import 'package:my_app/viewmodels/SpecialRecommend.dart';

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

  List<Widget> get _pages => [
    SingleChildScrollView(
      child: Column(
        children: [
          // 轮播图组件
          SliderSection(banners: _banners),
          SizedBox(height: 10),

          // 分类组件
          CategorySection(
            categoryList: _categoryList,
            onTap: (category) {
              print("点击了分类: ${category.name}");
            },
          ),
          SizedBox(height: 10),

          // 热门商品组件
          HotSection(preferenceList: _specialPreferenceList!),
          SizedBox(height: 10),

          // 推荐商品组件
          SuggestionSection(preferenceList: _specialPreferenceList!),
          SizedBox(height: 10),

          // 更多商品组件
          MoreSection(recommendList: _specialRecommendList),
          SizedBox(height: 20),
        ],
      ),
    ),
    CartPage(),
    CategoryPage(),
    MyPage(),
  ];

  final List<BannerItem> _banners = [
    BannerItem(id: "1", imgUrl: 'assets/banner/youyi1.jpg'),
    BannerItem(id: "2", imgUrl: 'assets/banner/youyi2.jpg'),
    BannerItem(id: "3", imgUrl: 'assets/banner/youyi3.jpg'),
    BannerItem(id: "4", imgUrl: 'assets/banner/youyi4.jpg'),
    BannerItem(id: "5", imgUrl: 'assets/banner/youyi5.jpg'),
  ];
  // 分类数据
  final List<CategoryItem> _categoryList = [];
  // 热门偏好数据
  SpecialRecommend? _specialPreferenceList;
  // 推荐商品数据
  final List<RecommendItem> _specialRecommendList = [];

  @override
  void initState() {
    super.initState();
    // 初始化轮播图数据
    getBannerList().then((value) {
      setState(() {
        _banners.addAll(value);
      });
    });
    // 初始化分类数据
    getHomeCategoryList().then((value) {
      setState(() {
        _categoryList.addAll(value);
        _categoryList.add(
          CategoryItem(
            id: "0",
            name: "すべて",
            picture: "assets/category/all.png",
          ),
        );
      });
    });
    // 初始化热门偏好数据
    getHotPreferenceList().then((value) {
      setState(() {
        _specialPreferenceList = value;
      });
    });
    // 初始化推荐商品数据
    getSpecialRecommendList().then((value) {
      setState(() {
        _specialRecommendList.addAll(value);
      });
    });
  }

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
