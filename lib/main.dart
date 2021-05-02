import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Bookmark.dart';
import 'SearchMedicine.dart';
import 'SearchPill.dart';

void main() {
  runApp(MaterialApp(
    title: '서연고',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle =
        OutlinedButton.styleFrom(textStyle: TextStyle(fontSize: 30));

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
                    style: TextStyle(fontSize: 120),
                  ),
                ),
              ]),

              // 버튼 배치
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 50),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchMedicine()),
                      );
                    },
                    child: Text('의약품 검색'),
                    style: buttonStyle,
                  ),
                  SizedBox(height: 40),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchPill()),
                      );
                    },
                    child: Text('낱알 검색'),
                    style: buttonStyle,
                  ),
                  SizedBox(height: 40),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Bookmark()),
                      );
                    },
                    child: Text('즐겨찾기'),
                    style: buttonStyle,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}