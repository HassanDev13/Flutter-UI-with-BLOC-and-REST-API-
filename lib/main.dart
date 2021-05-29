import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/client.dart';
import 'package:flutter_app/models/lesson.dart';
import 'package:flutter_app/provider/lessonProvider.dart';
import 'package:flutter_app/provider_archi/lessonProviderArchi.dart';
import 'package:flutter_app/repositorys/lessonRepository.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'bloc/lessonBloc.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LessonProviderArchi()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.getUser();
    LessonProviderArchi().dataChange();
    //  context.read<LessonProviderArchi>().dataChange();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  MyHomePage({Key key}) : super(key: key);
  String value = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          child: TextField(
              onChanged: (text) {
                value = text;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search . . .",

                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 32.0),
                      borderRadius: BorderRadius.circular(25.0)))),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.info,
              color: Colors.black54,
              size: 20.0,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Count(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black54,
        key: const Key('increment_floatingActionButton'),

        /// Calls `context.read` instead of `context.watch` so that it does not rebuild
        /// when [Counter] changes.

        onPressed: () => {
          /// you can use one of theme :
          Provider.of<LessonProviderArchi>(context, listen: false).dataChange(),
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Count extends StatelessWidget {
  const Count({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Lesson>(
      stream: bloc.subject.stream,
      builder: (context, AsyncSnapshot<Lesson> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.error != null) {
            return _buildErrorWidget(snapshot.error);
          }
          return _buildUserWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }
}

Widget _buildLoadingWidget() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [Text("Loading data from API..."), CircularProgressIndicator()],
  ));
}

Widget _buildErrorWidget(String error) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Error occured: $error"),
    ],
  ));
}
Widget buildSearchBar({String hintText}) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 8),
    decoration: boxDecorationWithRoundedCorners(backgroundColor: Colors.grey[200].withOpacity(0.4)),
    child: Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          iconSize: 20,
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        10.width,
        TextField(
          decoration: InputDecoration(contentPadding: EdgeInsets.zero, border: InputBorder.none, hintText: hintText),
        ).expand(),
      ],
    ),
  );
}


Widget _buildUserWidget(Lesson data) {
  List<Lessons> items = data.data.lessons;
  return Expanded(
    child: ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      child: ClipOval(
                        child: Image.network(
                          items[index].user.filePathImage,
                          height: 30,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.all(5),
                              child: Text('${items[index].user.username}')),
                          Container(
                            child: Icon(
                              Icons.navigate_next,
                              color: Colors.black54,
                              size: 20.0,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Divider(),
                Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.centerRight,
                    child: Text('${items[index].description}',
                        textDirection: TextDirection.rtl)),
                Divider(),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(child: Text("إبلاغ")),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.report,
                              color: Colors.black54,
                              size: 20.0,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(items[index].subjectNameLesson),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.download_rounded,
                              color: Colors.black54,
                              size: 20.0,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(items[index].downloadsNumber.toString()),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.download_rounded,
                              color: Colors.black54,
                              size: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    ),
  );


}
