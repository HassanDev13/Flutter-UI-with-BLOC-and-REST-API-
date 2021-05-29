class Lesson {
  String message;
  Data data;

  Lesson({this.message, this.data});

  Lesson.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int totalItems;
  int totalPages;
  String limit;
  String currentPageNumber;
  int currentPageSize;
  String nextPage;
  Null getPreviousPage;
  List<Lessons> lessons;

  Data(
      {this.totalItems,
      this.totalPages,
      this.limit,
      this.currentPageNumber,
      this.currentPageSize,
      this.nextPage,
      this.getPreviousPage,
      this.lessons});

  Data.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    limit = json['limit'];
    currentPageNumber = json['currentPageNumber'];
    currentPageSize = json['currentPageSize'];
    nextPage = json['nextPage'];
    getPreviousPage = json['getPreviousPage'];
    if (json['lessons'] != null) {
      lessons = new List<Lessons>();
      json['lessons'].forEach((v) {
        lessons.add(new Lessons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    data['totalPages'] = this.totalPages;
    data['limit'] = this.limit;
    data['currentPageNumber'] = this.currentPageNumber;
    data['currentPageSize'] = this.currentPageSize;
    data['nextPage'] = this.nextPage;
    data['getPreviousPage'] = this.getPreviousPage;
    if (this.lessons != null) {
      data['lessons'] = this.lessons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lessons {
  int id;
  String description;
  Null filePathPdf;
  Null fileMimetype;
  bool showing;
  int state;
  String codeLesson;
  String subjectNameLesson;
  bool fromGithub;
  String githubUrl;
  String idListCategory;
  String idListSubject;
  int downloadsNumber;
  String createdAt;
  String updatedAt;
  int userId;
  User user;

  Lessons(
      {this.id,
      this.description,
      this.filePathPdf,
      this.fileMimetype,
      this.showing,
      this.state,
      this.codeLesson,
      this.subjectNameLesson,
      this.fromGithub,
      this.githubUrl,
      this.idListCategory,
      this.idListSubject,
      this.downloadsNumber,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.user});

  Lessons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    filePathPdf = json['file_path_pdf'];
    fileMimetype = json['file_mimetype'];
    showing = json['showing'];
    state = json['state'];
    codeLesson = json['code_lesson'];
    subjectNameLesson = json['subject_name_lesson'];
    fromGithub = json['fromGithub'];
    githubUrl = json['github_url'];
    idListCategory = json['idListCategory'];
    idListSubject = json['idListSubject'];
    downloadsNumber = json['DownloadsNumber'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['file_path_pdf'] = this.filePathPdf;
    data['file_mimetype'] = this.fileMimetype;
    data['showing'] = this.showing;
    data['state'] = this.state;
    data['code_lesson'] = this.codeLesson;
    data['subject_name_lesson'] = this.subjectNameLesson;
    data['fromGithub'] = this.fromGithub;
    data['github_url'] = this.githubUrl;
    data['idListCategory'] = this.idListCategory;
    data['idListSubject'] = this.idListSubject;
    data['DownloadsNumber'] = this.downloadsNumber;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String username;
  String filePathImage;

  User({this.id, this.username, this.filePathImage});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    filePathImage = json['file_path_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['file_path_image'] = this.filePathImage;
    return data;
  }
}
