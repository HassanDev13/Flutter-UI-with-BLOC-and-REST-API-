import 'package:flutter_app/models/lesson.dart';
import 'package:flutter_app/provider/lessonProvider.dart';

class LessonRepository {
  LessonProvider lessonProvider = new LessonProvider();


  Future<Lesson> getLesson()  {
    return lessonProvider.fetchAllProduct();
  }

  
}