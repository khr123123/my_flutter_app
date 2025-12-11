import 'package:flutter/material.dart';
import 'package:my_app/viewmodels/SpecialRecommend.dart';

class SuggestionSection extends StatelessWidget {
  const SuggestionSection({super.key, required this.preferenceList});

  final SpecialRecommend preferenceList;

  @override
  Widget build(BuildContext context) {
    final items = (preferenceList.subTypes.length > 1)
        ? preferenceList.subTypes[1].goodsItems.items
        : <GoodsItem>[];

    if (items.isEmpty) {
      return SizedBox();
    }

    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.recommend, color: Colors.amber, size: 28),
                  SizedBox(width: 5),
                  Text(
                    'おすすめ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              TextButton(onPressed: () {}, child: Text("もっと見る >")),
            ],
          ),

          SizedBox(height: 10),

          // 横向滑动推荐
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final product = items[index];

                return Container(
                  width: 160,
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 上方图片（与你的热门页面完全一致）
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        child: Image.network(
                          product.picture,
                          width: 160,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // 下方文字内容
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 名称
                            Text(
                              product.name,
                              style: TextStyle(fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),

                            // ⭐ 评分（新增）
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 16),
                                SizedBox(width: 4),
                                Text("4.5", style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            SizedBox(height: 4),

                            // 价格
                            Text(
                              "¥${product.price}",
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
