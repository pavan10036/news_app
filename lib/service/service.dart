import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class ApiService {
  Future fetchNews() async {
    var now = DateTime.now().subtract(
      const Duration(
        days: 31,
      ),
    );
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    Response response = await http.get(
      Uri.parse(
          "https://newsapi.org/v2/everything?q=tesla&from=${formattedDate}&sortBy=publishedAt&apiKey=21e2a8c3ad014ecaac98c41847de5aba"),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response;
    }
  }
}
