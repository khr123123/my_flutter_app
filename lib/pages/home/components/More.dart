import 'package:flutter/material.dart';

class MoreSection extends StatelessWidget {
  const MoreSection({super.key});

  final List<Map<String, dynamic>> moreProducts = const [
    {
      "name": "コーヒーメーカー",
      "price": "¥12,800",
      "image": "https://via.placeholder.com/300x200/FD79A8/FFFFFF?text=More+1",
      "description": "自宅で本格的なコーヒーを"
    },
    {
      "name": "ヨガマット",
      "price": "¥3,500",
      "image": "https://via.placeholder.com/300x200/FDCB6E/000000?text=More+2",
      "description": "滑り止め付き高品質"
    },
    {
      "name": "デスクランプ",
      "price": "¥5,900",
      "image": "https://via.placeholder.com/300x200/6C5CE7/FFFFFF?text=More+3",
      "description": "目に優しいLED照明"
    },
    {
      "name": "ブレンダー",
      "price": "¥8,200",
      "image": "https://via.placeholder.com/300x200/00B894/FFFFFF?text=More+4",
      "description": "パワフルな粉砕力"
    },
    {
      "name": "トラベルバッグ",
      "price": "¥9,800",
      "image": "https://via.placeholder.com/300x200/E17055/FFFFFF?text=More+5",
      "description": "大容量で軽量"
    },
    {
      "name": "ワイヤレスマウス",
      "price": "¥2,500",
      "image": "https://via.placeholder.com/300x200/0984E3/FFFFFF?text=More+6",
      "description": "静音設計で快適"
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                      child: Image.network(
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
