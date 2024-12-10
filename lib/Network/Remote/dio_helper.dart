import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:todo_app/Shared/Components/Constants.dart';

class DioHelper {

  static late Dio dio;


  static init() {
    dio = Dio(BaseOptions(baseUrl: base_url , receiveDataWhenStatusError: true));
  }

  static Future<Response?> getData({required String url , required Map<String, dynamic> query}) async {
    return await dio.get(url, queryParameters: query,);
  }

}
