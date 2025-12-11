import 'package:dio/dio.dart';
import 'package:my_app/constants/ApiConstant.dart';
import 'package:my_app/request/DioRequest.dart';
import 'package:my_app/viewmodels/BannerItem.dart';
import 'package:my_app/viewmodels/CategoryItem.dart';
import 'package:my_app/viewmodels/Recommend.dart';
import 'package:my_app/viewmodels/SpecialRecommend.dart';

Future<List<BannerItem>> getBannerList() async {
  try {
    final response = await dioRequest.get(ApiConstant.bannerListUrl);
    if (response is List) {
      return response.map((e) => BannerItem.fromJson(e)).toList();
    }
    throw Exception('Invalid response format');
  } on DioException {
    rethrow;
  }
}

Future<List<CategoryItem>> getHomeCategoryList() async {
  try {
    final response = await dioRequest.get(ApiConstant.homeCategoryUrl);
    if (response is List) {
      return response.map((e) => CategoryItem.fromJson(e)).toList();
    }
    throw Exception('Invalid response format');
  } on DioException {
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
