class RecommendItem {
  final String id;
  final String name;
  final double price;
  final String picture;
  final int payCount;

  RecommendItem({
    required this.id,
    required this.name,
    required this.price,
    required this.picture,
    required this.payCount,
  });

  factory RecommendItem.fromJson(Map<String, dynamic> json) {
    return RecommendItem(
      id: json['id']?.toString() ?? "",
      name: json['name'] ?? "",
      price: (json['price'] as num).toDouble(),   // 🔥 关键修复
      picture: json['picture'] ?? "",
      payCount: json['payCount'] ?? 0,
    );
  }
}
