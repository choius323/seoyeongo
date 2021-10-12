import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  runApp(MaterialApp(
    title: '서연고',
    home: MyApp(),
    theme: ThemeData.light(),
  ));
}

class MyApp extends StatelessWidget {
  SharedPreferences _preferences;
  List bookmarkList;

  final ButtonStyle buttonStyle =
      OutlinedButton.styleFrom(textStyle: TextStyle(fontSize: 30));

  @override
  Widget build(BuildContext context) {
    checkPreferences();

    checkPreferences();
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '서연고 ',
                      style: TextStyle(fontSize: 80),
                    ),
                    //https://www.flaticon.com/premium-icon/pill_384260?term=pill&page=1&position=9&page=1&position=9&related_id=384260&origin=search
                    Image.asset(
                      'images/pill.png',
                      height: 80,
                    ),
                  ],
                )),

            // 버튼 배치
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _mainButton(context, SearchMedicine(), '의약품 검색'),
                  _mainButton(context, SearchPill(), '낱알 검색'),
                  OutlinedButton(
                    onPressed: () {
                      List list = _preferences.getStringList('bookmarkList');
                      print(list);
                      if (list.isEmpty) {
                        //즐겨찾기된 항목이 없으면 목록 출력 X
                        print('bookmark is empty');
                        Fluttertoast.showToast(
                            msg: '즐겨찾기된 항목이 없습니다.', toastLength: Toast.LENGTH_LONG);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MedicineListDB(
                                itemSeqList:
                                    _preferences.getStringList('bookmarkList'),
                              ),
                            ));
                      }
                    },
                    child: Text('즐겨찾기'),
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

  //북마크 프레퍼런스
  Future checkPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    if (_preferences.getStringList('bookmarkList') == null) {
      await _preferences.setStringList(
          'bookmarkList', new List.empty(growable: true));
    }
    print(
        'bookmarkList : ' + _preferences.getStringList('bookmarkList').toString());

    bookmarkList = _preferences.getStringList('bookmarkList');
  }
}
