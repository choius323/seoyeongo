import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SearchMedicine.dart';
import 'SearchPill.dart';
import 'medicineListDB.dart';

void main() {
  // 화면전환 고정
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MaterialApp(
        title: '서연고',
        home: MyApp(),
        theme: ThemeData(
            scaffoldBackgroundColor: Color.fromARGB(230, 51, 204, 204),
            appBarTheme: AppBarTheme(
                centerTitle: true,
                backgroundColor: Color.fromARGB(150, 30, 190, 174)),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                  elevation: 0,
                  primary: Colors.white70,
                  // onSurface: Colors.red,
                  textStyle: TextStyle(fontSize: 20),
                  minimumSize: Size(100, 20),
                  backgroundColor: Colors.black12),
            ))),
  );
}

class MyApp extends StatelessWidget {
  SharedPreferences _preferences;
  List bookmarkList;

  final ButtonStyle buttonStyle = OutlinedButton.styleFrom(
    textStyle: TextStyle(fontSize: 30),
  );

  @override
  Widget build(BuildContext context) {
    checkPreferences();
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color.fromARGB(250, 51, 204, 204),
            Color.fromARGB(130, 40, 197, 202)
          ])),
      child: Scaffold(
        appBar: AppBar(
          title: Text('서연고'),
          toolbarHeight: 0,
        ),
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(bottom: 50),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Image.asset(
                        'images/icons/pill2.png',
                        height: 70,
                      ),
                    ),
                    Text(
                      ' 서연고 ',
                      style: TextStyle(fontSize: 80),
                    ),
                    Flexible(
                      child: Image.asset(
                        'images/icons/ointment2.png',
                        height: 70,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),

              // 버튼 배치
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _mainButton(
                        context, SearchMedicine(), '의약품 검색', 'search2.png'),
                    _mainButton(context, SearchPill(), '낱알 검색', 'camera2.png'),
                    OutlinedButton(
                      onPressed: () {
                        List list = _preferences.getStringList('bookmarkList');
                        print(list);
                        if (list.isEmpty) {
                          //즐겨찾기된 항목이 없으면 목록 출력 X
                          print('bookmark is empty');
                          Fluttertoast.showToast(
                              msg: '즐겨찾기된 항목이 없습니다.',
                              toastLength: Toast.LENGTH_LONG);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => MedicineListDB(
                          //         searchType: MedicineListDB.BOOKMARK,
                          //         itemSeqList:
                          //             _preferences.getStringList('bookmarkList'),
                          //       ),
                          //     ));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MedicineListDB(
                                  searchType: MedicineListDB.BOOKMARK,
                                  itemSeqList: _preferences
                                      .getStringList('bookmarkList'),
                                ),
                              ));
                        }
                      },
                      child: _buttonContent("즐겨찾기", "favourite2.png"),
                      style: buttonStyle,
                    ),

                    // _mainButton(context, WebTest(), 'Flask Test'),
                    // _mainButton(context, MyImagePicker(), 'Image Picker'),
                  ],
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  //버튼 생성 함수
  Widget _mainButton(
      BuildContext context, var package, String text, String image) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => package));
      },
      child: _buttonContent(text, image),
      style: buttonStyle,
    );
  }

  Widget _buttonContent(String text, String image) {
    return Container(
      width: 230,
      // alignment: Alignment.center,
      // constraints: BoxConstraints(MediaQuery.of(context).size.width / 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          SizedBox(
            width: 15,
          ),
          Container(
              height: 50,
              child: Image.asset("images/icons/$image", fit: BoxFit.fitHeight))
        ],
      ),
    );
  }

  //북마크 프레퍼런스
  Future checkPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    if (_preferences.getStringList('bookmarkList') == null) {
      await _preferences.setStringList(
          'bookmarkList', new List.empty(growable: true));
    }
    print('bookmarkList : ' +
        _preferences.getStringList('bookmarkList').toString());

    bookmarkList = _preferences.getStringList('bookmarkList');
  }
}
