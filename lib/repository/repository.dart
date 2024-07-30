import 'dart:convert';
import '../model/get_news_model.dart';
import '../service/service.dart';

class Repository {
  ApiService apiService = ApiService();

  Future<GetNewsModel?> fetchNews() async {
    dynamic response = await apiService.fetchNews();
    GetNewsModel? getNewsData = GetNewsModel.fromJson(
      jsonDecode(response),
    );
    return getNewsData;
  }
}
