class ApiConstant {
  static const String baseUrl = "http://meikou-api.itheima.net";
  static const int timeout = 10;
  static const String successCode = "1";
  static const String errorCode = "0";

  static const String bannerListUrl = "/home/banner";
  static const String hotPreferenceUrl = "/hot/preference";
  static const String hotCategoryUrl = "/hot/category";
  static const String productListUrl = "/product/list";
  static const String productDetailUrl = "/product/detail";
  static const String cartListUrl = "/cart/list";
  static const String cartAddUrl = "/cart/add";
  static const String cartDeleteUrl = "/cart/delete";
  static const String cartUpdateUrl = "/cart/update";
  static const String orderCreateUrl = "/order/create";
  static const String orderDetailUrl = "/order/detail";
  static const String orderListUrl = "/order/list";
  static const String orderDeleteUrl = "/order/delete";
  static const String orderPayUrl = "/order/pay";
  static const String orderPaySuccessUrl = "/order/pay/success";
  static const String orderPayCancelUrl = "/order/pay/cancel";
  static const String orderPaySuccessCallbackUrl =
      "/order/pay/success/callback";
  static const String orderPayCancelCallbackUrl = "/order/pay/cancel/callback";
}
