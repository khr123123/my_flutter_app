import 'package:dio/dio.dart';
import 'package:my_app/constants/ApiConstant.dart';
import 'package:my_app/request/DioRequest.dart';
import 'package:my_app/viewmodels/BannerItem.dart';

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
