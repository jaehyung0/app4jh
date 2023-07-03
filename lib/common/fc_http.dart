import 'dart:convert';

import 'package:http/http.dart' as http;

class FcHttp {
  static String apiUrl = 'openapi.naver.com';
  static String path = '/v1/search/news.json';
  static String clientID = 'zg1dOzIN6_kNNlrMVlmE'; //'X-Naver-Client-Id'
  static String clientSecret = 'vRe0xMsKRs'; //'X-Naver-Client-Secret'

  static String requestBody =
      "{\"startDate\":\"2023-01-01\",\"endDate\":\"2023-06-27\",\"timeUnit\":\"month\",\"keywordGroups\":[{\"groupName\":\"FC서울\",\"keywords\":[\"승리\",\"이적\"]}],\"device\":\"pc\",\"ages\":[\"1\",\"2\"],\"gender\":\"f\"}";

  static Future<Map<String, dynamic>> callApi(String keyword) async {
    var encoded = Uri.encodeQueryComponent(keyword);
    //var url = Uri.parse('$apiUrl?query= $encoded');
    var url = Uri.https(apiUrl, path, {'query':keyword});
    Map<String, String> header = {
      'X-Naver-Client-Id': clientID,
      'X-Naver-Client-Secret': clientSecret,
      'Content-Type': 'application/json',
    };
    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }
}
