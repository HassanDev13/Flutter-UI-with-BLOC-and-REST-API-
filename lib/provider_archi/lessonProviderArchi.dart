import 'package:flutter/cupertino.dart';
import 'package:flutter_app/repositorys/lessonRepository.dart';

class LessonProviderArchi with ChangeNotifier {
  var _data ;

  int get getData => _data;

  void dataChange() {
    _data = LessonRepository().getLesson();
    notifyListeners();
  }
}