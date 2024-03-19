import 'package:dio/dio.dart';
import 'package:dio_api/model.dart';
import 'package:flutter/material.dart';

class ApiHelper {
  late Dio dio;

  ApiHelper() {
    dio = Dio();
  }

  final String url = 'https://jsonplaceholder.typicode.com/albums/';
  Map<String, dynamic> queryParams = {
    'page': 1,
    'limit': 3,
  };

  Map<String, dynamic> headers = {
    'Authorization': 'Bearer YourAccessToken',
    'Content-Type': 'application/json',
  };

  //dio get
  Future<List<Model>> fetchData() async {
    final response = await dio.get(
        'https://jsonplaceholder.typicode.com/albums',
        queryParameters: queryParams,
        options: Options(headers: headers));
    if (response.statusCode == 200) {
      return List.from(response.data).map((e) => Model.fromJson(e)).toList();
    } else {
      throw Exception('data no found');
    }
  }

  //dio post
  Future<void> postData(String title, context) async {
    final response = await dio.post(url, data: {'title': 'nehal shinde'});
    if (response.statusCode == 201) {
      debugPrint('post Data :::::: $response');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.toString())));
    } else {
      throw Exception('data no found');
    }
  }

  ///dio interceptor
  Future<void> dioInterceptorRequest() async {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      //options.headers['Authorization'] = 'auth token';
      options.headers.addAll({
        'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
        'Custom-Header': 'your custom header value'
      });
      // print('request interceptor ======> ${options.method} - ${options.uri}');
      return handler.next(options);
    }));
    //var response = await dio.get('https://jsonplaceholder.typicode.com/albums/1');
    //print('responsee data  interceptor=====> ${response.data}');
  }

  // Map<String,dynamic> dynamicHeader(){
  //   Map<String, dynamic> headers = {
  //     'Authorization' : 'Bearer YOUR_ACCESS_TOKEN',
  //     'Custom-Header' : 'your custom header value'
  //   };
  //   return headers;
  // }
  void interceptorData() async {
    String url = 'https://jsonplaceholder.typicode.com/posts/1';
    try {
      final response = await dio.get(url);
      print('interceptorData ======> ${response.data}');
    } catch (e) {
      print('exception ====> $e');
    }
  }

// Future<void> dioInterceptorResponse() async{
//   dio.interceptors.add(
//       InterceptorsWrapper(
//           onResponse: (options, handler){
//             //options.headers['Authorization'] = 'auth token';
//             print('Response ========> ${options.statusCode} ${options.data}');
//             return handler.next(options);
//           }
//       )
//   );
//   final response = await dio.get('https://jsonplaceholder.typicode.com/albums/1');
//   print(response.data);
// }

// CancelToken() async{
//     final cancelToken = CancelToken();
//     final response = await dio.get(url, cancelToken: cancelToken);
//     print('cancel Token ======> ${response.data}');
//     //cancelToken.cancel('Request Cancel');
// }
}
