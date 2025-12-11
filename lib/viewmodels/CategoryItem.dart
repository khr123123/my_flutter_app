class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem> children;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    List<CategoryItem>? children,
  }) : children = children ?? [];

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'],
      name: json['name'],
      picture: json['picture'],
      children: json['children'] != null
          ? (json['children'] as List)
                .map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
                .cast<CategoryItem>()
                .toList()
          : null,
    );
  }
}
