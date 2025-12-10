import 'package:flutter/material.dart';

class HotSection extends StatelessWidget {
  const HotSection({super.key});

  final List<Map<String, dynamic>> hotProducts = const [
    {
      "name": "ワイヤレスイヤホン",
      "price": "¥8,900",
      "image": "https://via.placeholder.com/200x200/FF6B6B/FFFFFF?text=Hot+1",
      "discount": "20% OFF"
    },
    {
      "name": "スマートウォッチ",
      "price": "¥15,800",
      "image": "https://via.placeholder.com/200x200/4ECDC4/FFFFFF?text=Hot+2",
      "discount": "15% OFF"
    },
    {
      "name": "Bluetoothスピーカー",
      "price": "¥6,500",
      "image": "https://via.placeholder.com/200x200/45B7D1/FFFFFF?text=Hot+3",
      "discount": "30% OFF"
    },
    {
      "name": "ノートパソコン",
      "price": "¥89,000",
      "image": "https://via.placeholder.com/200x200/96CEB4/FFFFFF?text=Hot+4",
      "discount": "10% OFF"
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
              Row(
                children: [
                  Icon(Icons.local_fire_department, color: Colors.red, size: 28),
                  SizedBox(width: 5),
                  Text(
                    '人気商品',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  print('View all hot products');
                },
                child: Text('もっと見る >'),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hotProducts.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 160,
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.network(
                              hotProducts[index]["image"],
                              width: 160,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                hotProducts[index]["discount"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hotProducts[index]["name"],
                              style: TextStyle(fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              hotProducts[index]["price"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
