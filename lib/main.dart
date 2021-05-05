import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Bookmark.dart';
import 'SearchMedicine.dart';
import 'SearchPill.dart';

void main() {
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
    double boxSize = 40;
    return Scaffold(
      appBar: AppBar(
        title: Text('서연고'),
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Text(
                    '서연고',
                    style: TextStyle(fontSize: 100),
                  ),
                ),
              ]),

              // 버튼 배치
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: boxSize * 1.5),
                  _mainButton(context, SearchMedicine(), '의약품 검색'),
                  SizedBox(height: boxSize),
                  _mainButton(context, SearchPill(), '낱알 검색'),
                  SizedBox(height: boxSize),
                  _mainButton(context, Bookmark(), '즐겨찾기'),
                ],
              ),
            ],
          )),
    );
  }
  
  //버튼 생성 함수
  Widget _mainButton(BuildContext context, dynamic package, String text) {
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
