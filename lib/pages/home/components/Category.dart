import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  final List<Map<String, dynamic>> categories = const [
    {"name": "ファッション", "icon": Icons.checkroom, "color": Colors.pink},
    {"name": "電子機器", "icon": Icons.phone_android, "color": Colors.blue},
    {"name": "食品", "icon": Icons.restaurant, "color": Colors.orange},
    {"name": "家具", "icon": Icons.weekend, "color": Colors.brown},
    {"name": "美容", "icon": Icons.face, "color": Colors.purple},
    {"name": "スポーツ", "icon": Icons.sports_basketball, "color": Colors.green},
    {"name": "本", "icon": Icons.book, "color": Colors.teal},
    {"name": "その他", "icon": Icons.more_horiz, "color": Colors.grey},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'カテゴリ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.85,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print('Category tapped: ${categories[index]["name"]}');
                },
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: categories[index]["color"].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        categories[index]["icon"],
                        size: 32,
                        color: categories[index]["color"],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      categories[index]["name"],
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
