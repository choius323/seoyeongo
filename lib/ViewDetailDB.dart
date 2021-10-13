import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:seoyeongo/DBHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MedicineInfo2.dart';

class ViewDetailDB extends StatefulWidget {
  final MedicineInfo2 med;
  final DBHelper db;

  ViewDetailDB({this.med, this.db});

  @override
  _ViewDetailDBState createState() => _ViewDetailDBState(med: med, db: db);
}

class _ViewDetailDBState extends State<ViewDetailDB> {
  final MedicineInfo2 med;
  final DBHelper db;
  List _bookmark;
  SharedPreferences _preferences;
  bool isFavorite;
  bool isChanged = false;

  _ViewDetailDBState({this.med, this.db});

  @override
  Widget build(BuildContext context) {
    checkPreferences().then((value) => isFavorite = value);

    // print("id : $med");
    // print("db : $db");
    return Scaffold(
      appBar: AppBar(
        title: Text('검색 결과'),
        actions: [
          // FavoriteButton(
          //   //수정 필요(아이콘 항상 켜져 있음)
          //   isFavorite: isFavorite,
          //   valueChanged: (_isFavorite) {
          //     if (_isFavorite == true) {
          //       _bookmark.add(med.itemseq);
          //       print(_bookmark.toString());
          //     } else {
          //       _bookmark.remove(med.itemseq);
          //       print(_bookmark.toString());
          //     }
          //     setPreferences();
          //   },
          // ),
          // switchStarIcon(),
          new IconButton(
              onPressed: () {
                if (_bookmark.contains(med.itemseq) != true) {
                  _bookmark.add(med.itemseq);
                  Fluttertoast.showToast(
                      msg: '즐겨찾기에 추가됐습니다.', toastLength: Toast.LENGTH_SHORT);
                } else {
                  _bookmark.remove(med.itemseq);
                  Fluttertoast.showToast(
                      msg: '즐겨찾기에서 제거됐습니다.', toastLength: Toast.LENGTH_SHORT);
                }
                isChanged = true;
                print(_bookmark.toString());
                setPreferences();
              },
              icon: new Icon(Icons.star)),
        ],
      ),
      body: _scrollView(),
    );
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      checkPreferences();
    });
  }


  @override
  void dispose() {
    print("${context.widget} isChanged : $isChanged");
    // Navigator.pop(context, isChanged);
    super.dispose();
  }

  Widget _scrollView() {
    //   MedicineInfo2 data = snapshot.data[0];

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Image.network(
              med.itemimage,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            // SizedBox(height: 20),
            // a ?? b   ==   a ? a==null ? b
            Text('제품명 : ' + (med.itemname ?? '없음')),
            Text('제품번호 : ' + (med.itemseq ?? '없음')),
            Text('제조사 : ' + (med.entpname ?? '없음')),
            Text('성상 : ' + (med.chart ?? '없음')),
            Text('앞 글자 : ' + (med.printfront ?? '없음')),
            Text('뒤 글자 : ' + (med.printback ?? '없음')),
            Text('앞 색 : ' + (med.colorclass1 ?? '없음')),
            Text('뒤 색 : ' + (med.colorclass2 ?? '없음')),
            Text('앞 모양 : ' + (med.markcodefront ?? '없음')),
            Text('뒤 모양 : ' + (med.markcodeback ?? '없음')),
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }

  String viewText(String text) {
    if (text == null) {
      return "없음";
    } else {
      return text;
    }
  }

  Widget switchStarIcon() {
    return new IconButton(
        onPressed: () => {}, icon: new Icon(CupertinoIcons.star));
  }

  Future<dynamic> checkPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    _bookmark = _preferences.getStringList('bookmarkList');
    if (_bookmark.contains(med.itemseq)) {
      isFavorite = true;
      return true;
    } else {
      isFavorite = false;
      return false;
    }
    print(_bookmark.contains(med.itemseq));
  }

  Future setPreferences() async {
    await _preferences.setStringList('bookmarkList', _bookmark);
  }

// Widget _scrollView(var snapshot) {
//   MedicineInfo2 data = snapshot.data[0];
//
//   return SingleChildScrollView(
//     child: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 20),
//           Image.network(
//             data.itemimage,
//             height: MediaQuery.of(context).size.height * 0.3,
//           ),
//           SizedBox(height: 20),
//           Text('제품명 : ' + data.itemname),
//           Text('제품번호 : ' + data.itemseq),
//           Text('제조사 : ' + data.entpname),
//           Text('성상 : ' + data.chart),
//           Text('모양 : ' + data.drugshape),
//         ],
//       ),
//     ),
//   );
// }
}
