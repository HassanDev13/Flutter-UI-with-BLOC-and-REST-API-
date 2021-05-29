import 'package:flutter_app/models/lesson.dart';
import 'package:flutter_app/repositorys/lessonRepository.dart';
import 'package:rxdart/rxdart.dart';

class LessonBloc {
  final LessonRepository _repository = LessonRepository();
  final BehaviorSubject<Lesson> _subject = BehaviorSubject<Lesson>();


  getUser() async {
    Lesson response = await _repository.getLesson();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<Lesson> get subject => _subject;
}
final bloc = LessonBloc();