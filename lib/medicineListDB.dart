import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:seoyeongo/LoadDB.dart';
import 'package:seoyeongo/viewDetail.dart';
import 'package:sqflite/sqflite.dart';

import 'MedicineInfo.dart';

class MedicineListDB extends StatefulWidget {
  String mNum;

  @override
  _MedicineListDBState createState() => _MedicineListDBState(mNum);

  MedicineListDB(this.mNum);
}

class _MedicineListDBState extends State<MedicineListDB> {
  int page = 1;
  String tag = 'id';

  String mName;
  String itemSeq;

  List<MedicineInfo> dataList = [];

  _MedicineListDBState(this.itemSeq);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('의약품 목록')),
        body: Column(
          children: <Widget>[
            _pageButtons(),
            Container(
              child: FutureBuilder(
                future:
                fetchString({'tag': tag, 'pages': page.toString()}, mName),
                builder: (context, snapshot) {
                  if (snapshot.hasError == true) {
                    print('snapshot.hasError -> $snapshot.hasError');
                    // 에러 메시지는 굳이 화면 가운데에 놓을 필요가 없다.
                    return Text('${snapshot.error}');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    // 나머지 공간 전체를 사용하는데, 전체 공간을 사용하지 않는 위젯이라면 가운데에 배치.
                    if (snapshot.data.toString() == '[]') {
                      return SizedBox();
                    } else {
                      return Expanded(child: _listView(snapshot.data));
                    }
                  }

                  // 인디케이터가 다른 위젯들처럼 화면 가운데에 위치시킨다.
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            _pageButtons(),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      getData();
    });
  }

  Future getData() async{
    final data = LoadDB(itemSeq);
    data.OpenDB();
    final futureList = data.getData() as List<MedicineInfo>;
    print('asdasd' + futureList.toString());
    print(data.getData());
  }

  Widget _pageButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: new Icon(Icons.arrow_back_outlined),
          onPressed: () {
            if (page > 1) {
              setState(() {
                page -= 1;
              });
            }
          },
        ),
        Text('$page'),
        IconButton(
            icon: new Icon(Icons.arrow_forward_outlined),
            onPressed: () {
              setState(() {
                page += 1;
              });
            })
      ],
    );
  }

  Widget _listView(String data) {
    return ListView.separated(scrollDirection: Axis.vertical,
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewDetail(null)));
          },title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              dataList[index].image,
              width: (40 * MediaQuery
                  .of(context)
                  .size
                  .width / 100),
              // width: 100,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('mName : ' + dataList[index].mName),
                Text('mNum : ' + dataList[index].mNum.toString()),
                Text('cName : ' + dataList[index].cName),
              ],
            )
          ],
        ),);
      },
    );
  }

  Future<void> fetchString(Map query, String mName) async {

  }
}
