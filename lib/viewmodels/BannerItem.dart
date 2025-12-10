class BannerItem {
  String imgUrl;
  String id;

  BannerItem({required this.imgUrl, required this.id});
  
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      imgUrl: json['imgUrl'],
      id: json['id'],
    );
  }
}
