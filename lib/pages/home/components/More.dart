import 'package:flutter/material.dart';

class MoreSection extends StatelessWidget {
  const MoreSection({super.key});

  final List<Map<String, dynamic>> moreProducts = const [
    {
      "name": "アパレルストア",
      "price": "¥12,800",
      "image": "assets/item/item1.jpg",
      "description": "洋服・アクセサリー専門店",
    },
    {
      "name": "スーパーマーケット",
      "price": "¥12,800",
      "image": "assets/item/item2.jpg",
      "description": "生鮮食品から日用品まで",
    },
    {
      "name": "家電量販店",
      "price": "¥12,800",
      "image": "assets/item/item3.jpg",
      "description": "最新家電からスマホまで",
    },
    {
      "name": "書店・文房具",
      "price": "¥12,800",
      "image": "assets/item/item4.jpg",
      "description": "本と文具の専門店",
    },
    {
      "name": "ドラッグストア",
      "price": "¥12,800",
      "image": "assets/item/item5.jpg",
      "description": "医薬品・健康食品・コスメ",
    },
    {
      "name": "ホームセンター",
      "price": "¥12,800",
      "image": "assets/item/item6.jpg",
      "description": "工具・建材・ガーデニング",
    },
    {
      "name": "ベーカリー",
      "price": "¥12,800",
      "image": "assets/item/item7.jpg",
      "description": "焼きたてパンの専門店",
    },
    {
      "name": "スポーツショップ",
      "price": "¥12,800",
      "image": "assets/item/item8.jpg",
      "description": "運動器具・ウェア",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'もっと見る',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.arrow_forward_ios, size: 18),
            ],
          ),
          SizedBox(height: 15),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: moreProducts.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10),
                      ),
                      child: Image.asset(
                        moreProducts[index]["image"],
                        width: 120,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              moreProducts[index]["name"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              moreProducts[index]["description"],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              moreProducts[index]["price"],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey),
                    SizedBox(width: 8),
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
