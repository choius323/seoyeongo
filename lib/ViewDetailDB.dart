import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seoyeongo/DBHelper.dart';

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

  _ViewDetailDBState({this.med, this.db});

  @override
  Widget build(BuildContext context) {
    print("id : $med");
    print("db : $db");
    return Scaffold(
      appBar: AppBar(
        title: Text('검색 결과'),
      ),
      // body: FutureBuilder(
      //   future: db.getDetailData(med.id),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError == true) {
      //       print('snapshot.hasError -> $snapshot.hasError');
      //       // 에러 메시지는 굳이 화면 가운데에 놓을 필요가 없다.
      //       return Text('${snapshot.error}');
      //     } else if (snapshot.connectionState == ConnectionState.done) {
      //       // 나머지 공간 전체를 사용하는데, 전체 공간을 사용하지 않는 위젯이라면 가운데에 배치.
      //       return _scrollView(snapshot);
      //     }
      //
      //     // 인디케이터가 다른 위젯들처럼 화면 가운데에 위치시킨다.
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),
      body: _scrollView(),
    );
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
