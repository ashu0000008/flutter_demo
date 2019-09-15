class ApiUrls{
  static const String ws_url = "ws://ashu.xyz:9000/ws";
  static const String ws_url1 = "ws://192.168.100.9:9000/ws";

  static const String base_url = "https://ashu.xyz";
  static const String base_url1 = "https://192.168.100.9";
  static const String url_get_crypto_percent = base_url + "/percent/";
  static const String url_get_platforms_summary = base_url + "/platforms/summary";
  static const String url_get_platform_info = base_url + "/platform/";
  static const String url_get_crypto_percent_history = base_url + "/percent/:symbol/history";

  static const String url_get_crypto_list = base_url + "/crypto/rank";
  static const String url_post_favorite = base_url + "/favorite";
  static const String url_remove_favorite = base_url + "/favorite";
  static const String url_get_favorite = base_url + "/favorite";


  static const String url_get_country = base_url + "/country";
}

