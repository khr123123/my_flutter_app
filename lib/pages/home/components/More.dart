import 'package:flutter/material.dart';
import 'package:my_app/viewmodels/Recommend.dart';

class MoreSection extends StatelessWidget {
  const MoreSection({super.key, required this.recommendList});

  final List<RecommendItem> recommendList;

  @override
  Widget build(BuildContext context) {
    // 空数据处理
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
              Text(
                'もっと見る',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.arrow_forward_ios, size: 18),
            ],
          ),

          SizedBox(height: 15),

          // 列表展示商品
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recommendList.length,
            itemBuilder: (context, index) {
              final item = recommendList[index];

              // 判断图片是否是网络资源
              Widget imageWidget;
              if (item.picture.startsWith('http')) {
                imageWidget = Image.network(
                  item.picture,
                  width: 120,
                  height: 100,
                  fit: BoxFit.cover,
                );
              } else {
                imageWidget = Image.asset(
                  item.picture,
                  width: 120,
                  height: 100,
                  fit: BoxFit.cover,
                );
              }

              return Container(
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    // 左侧图片
                    ClipRRect(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10),
                      ),
                      child: imageWidget,
                    ),

                    // 中间文字区域
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              item.name,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8),
                            Text(
                              '¥${item.price}',
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

                    // 右边箭头
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
