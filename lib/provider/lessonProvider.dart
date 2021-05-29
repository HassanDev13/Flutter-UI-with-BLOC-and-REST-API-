import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app/client.dart';
import 'package:flutter_app/models/lesson.dart';

class LessonProvider {
  Client _client = Client();

  LessonProvider();

  Future<Lesson> fetchAllProduct() async {
    try{
      final response = await _client.init().get('lesson?idListCategory=8&idListSubject=-1&page=0&limit=50');
      // It's better to return a Model class instead but this is
      // only for example purposes only
      Lesson lesson = Lesson.fromJson(response.data);
      return lesson;
    }
    on DioError catch(ex){
      // Assuming there will be an errorMessage property in the JSON object
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw new Exception(errorMessage);
    }
  }

}