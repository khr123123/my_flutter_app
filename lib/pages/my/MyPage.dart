import 'package:flutter/material.dart';
import 'package:my_app/pages/login/LoginPage.dart';
import 'package:pocketbase/pocketbase.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final pb = PocketBase('http://127.0.0.1:8090');
  bool isLoggedIn = false;
  String userName = 'ゲスト';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() {
    setState(() {
      isLoggedIn = pb.authStore.isValid;
      if (isLoggedIn) {
        final user = pb.authStore.model;
        userName = user?.data['name'] ?? 'ユーザー';
        userEmail = user?.data['email'] ?? '';
      }
    });
  }

  Future<void> logout() async {
    pb.authStore.clear();
    setState(() {
      isLoggedIn = false;
      userName = 'ゲスト';
      userEmail = '';
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('ログアウトしました')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'マイページ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
            onPressed: () {
              // 设置页面
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 用户信息卡片
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // 头像
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 16),

                  // 用户信息
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (isLoggedIn) ...[
                          const SizedBox(height: 4),
                          Text(
                            userEmail,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // 登录/箭头
                  if (!isLoggedIn)
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        ).then((_) => checkLoginStatus());
                      },
                      child: const Text(
                        'ログイン',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  else
                    const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 订单状态
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'マイオーダー',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // 查看全部订单
                          },
                          child: Row(
                            children: [
                              Text(
                                'すべて見る',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 13,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 18,
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 订单状态图标
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildOrderStatusItem(Icons.payment, '支払い待ち', 0),
                      _buildOrderStatusItem(
                        Icons.local_shipping_outlined,
                        '配送中',
                        0,
                      ),
                      _buildOrderStatusItem(
                        Icons.inventory_2_outlined,
                        '受取待ち',
                        0,
                      ),
                      _buildOrderStatusItem(
                        Icons.rate_review_outlined,
                        'レビュー',
                        0,
                      ),
                      _buildOrderStatusItem(Icons.cached, '返品/交換', 0),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 功能菜单
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _buildMenuItem(Icons.favorite_border, 'お気に入り', () {}),
                  _buildDivider(),
                  _buildMenuItem(Icons.local_offer_outlined, 'クーポン', () {}),
                  _buildDivider(),
                  _buildMenuItem(Icons.location_on_outlined, 'アドレス管理', () {}),
                  _buildDivider(),
                  _buildMenuItem(Icons.credit_card_outlined, '支払い方法', () {}),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 服务菜单
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _buildMenuItem(Icons.help_outline, 'ヘルプセンター', () {}),
                  _buildDivider(),
                  _buildMenuItem(
                    Icons.headset_mic_outlined,
                    'カスタマーサービス',
                    () {},
                  ),
                  _buildDivider(),
                  _buildMenuItem(Icons.info_outline, '会社概要', () {}),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // 登出按钮
            if (isLoggedIn)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: logout,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'ログアウト',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatusItem(IconData icon, String label, int count) {
    return GestureDetector(
      onTap: () {
        // 跳转到对应订单列表
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 28, color: Colors.black87),
              ),
              if (count > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      count.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title, style: const TextStyle(fontSize: 15)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey[200],
      indent: 56,
    );
  }
}
