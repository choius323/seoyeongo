import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'Bookmark.dart';
import 'SearchMedicine.dart';
import 'SearchPill.dart';

void main() {
  // 화면전환 고정
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MaterialApp(
    title: '서연고',
    home: MyApp(),
    theme: ThemeData.light(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final ButtonStyle buttonStyle =
      OutlinedButton.styleFrom(textStyle: TextStyle(fontSize: 30));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('서연고'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(bottom: 50),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                '서연고',
                style: TextStyle(fontSize: 100),
              ),
            ),

            // 버튼 배치
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _mainButton(context, SearchMedicine(), '의약품 검색'),
                  _mainButton(context, SearchPill(), '낱알 검색'),
                  _mainButton(context, Bookmark(), '즐겨찾기'),
                  // _mainButton(context, WebTest(), 'Flask Test'),
                  // _mainButton(context, MyImagePicker(), 'Image Picker'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //버튼 생성 함수
  Widget _mainButton(BuildContext context, package, String text) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => package));
      },
      child: Text(text),
      style: buttonStyle,
    );
  }
}
