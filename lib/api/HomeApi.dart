import 'package:dio/dio.dart';
import 'package:my_app/constants/ApiConstant.dart';
import 'package:my_app/request/DioRequest.dart';
import 'package:my_app/viewmodels/BannerItem.dart';
import 'package:my_app/viewmodels/CategoryItem.dart';
import 'package:my_app/viewmodels/Recommend.dart';
import 'package:my_app/viewmodels/SpecialRecommend.dart';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('http://127.0.0.1:8090');

// 获取PocketBase文件字段的URL
String pbFileUrl(RecordModel record, String fileName) {
  return "${pb.baseURL}/api/files/${record.collectionId}/${record.id}/$fileName";
}

// 获取轮播图列表
Future<List<BannerItem>> getBannerList() async {
  try {
    final result = await pb.collection('banner').getList(page: 1, perPage: 20);
    return result.items.map((record) {
      return BannerItem.fromJson({
        ...record.data, // PocketBase 返回的数据 (Map)
        "id": record.id, // 单独补充 recordId（如果你的 model 需要）
        "imgUrl": pbFileUrl(record, record.data["imgUrl"]), // PocketBase 文件字段处理
      });
    }).toList();
  } catch (e) {
    rethrow;
  }
}

Future<List<CategoryItem>> getHomeCategory() async {
  try {
    final result = await pb
        .collection('categories')
        .getFullList(sort: "sort", filter: "childIds != '[]'");
    return result.map((record) {
      return CategoryItem.fromJson({
        ...record.data,
        "id": record.id,
        "picture": pbFileUrl(record, record.data["picture"]),
      });
    }).toList();
  } catch (e) {
    rethrow;
  }
}

Future<SpecialRecommend> getHotPreferenceList() async {
  try {
    final response = await dioRequest.get(ApiConstant.hotPreferenceUrl);
    return SpecialRecommend.fromJson(response);
  } on DioException {
    rethrow;
  }
}

Future<List<RecommendItem>> getSpecialRecommendList() async {
  try {
    final response = await dioRequest.get(ApiConstant.specialRecommendUrl);
    if (response is List) {
      return response.map((e) => RecommendItem.fromJson(e)).toList();
    }
    throw Exception('Invalid response format');
  } on DioException {
    rethrow;
  }
}
