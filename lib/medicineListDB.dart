import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seoyeongo/DBHelper.dart';

import 'MedicineInfo2.dart';
import 'ViewDetailDB.dart';

class MedicineListDB extends StatefulWidget {
  final String itemseq;
  final String itemname;

  @override
  _MedicineListDBState createState() =>
      _MedicineListDBState(itemseq: itemseq, itemname: itemname);

  MedicineListDB({this.itemseq, this.itemname});
}

class _MedicineListDBState extends State<MedicineListDB> {
  int page = 1;
  String tag = 'id';
  final String itemseq;
  final String itemname;
  DBHelper db;

  _MedicineListDBState({this.itemseq, this.itemname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('의약품 목록')),
        body: Column(
          children: <Widget>[
            _pageButtons(),
            Container(
              child: FutureBuilder(
                future: Future.delayed(
                    Duration(milliseconds: 500),
                    () => db.getDBData(
                        page: page, itemseq: itemseq, itemname: itemname)),
                builder:
                    (context, AsyncSnapshot<List<MedicineInfo2>> snapshot) {
                  if (snapshot.hasError == true) {
                    print('snapshot.hasError -> ${snapshot.error}');
                    return Text('${snapshot.error}');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    // 나머지 공간 전체를 사용하는데, 전체 공간을 사용하지 않는 위젯이라면 가운데에 배치.
                    if (snapshot.data.isEmpty) {
                      return SizedBox();
                    } else {
                      return Expanded(child: _listView(snapshot));
                    }
                  }

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
      getDB();
    });
  }

  Future getDB() async {
    db = DBHelper();
    db.openDB();
    // Future.delayed(Duration(seconds: 1), () => getData());
  }

  // Future getData() async {
  //   print("medicineListDB data : $db");
  //   dataList = db.getDBData();
  // }

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

  Widget _listView(var snapshot) {
    List<MedicineInfo2> dataList = snapshot.data;

    return ListView.separated(
      scrollDirection: Axis.vertical,
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
                    builder: (context) => ViewDetailDB(
                          med: dataList[index],
                          db: db,
                        )));
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                dataList[index].itemimage,
                width: (40 * MediaQuery.of(context).size.width / 100),
                // width: 100,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("제품명 : " + dataList[index].itemname),
                    Text('제품번호 : ' + dataList[index].itemseq),
                    Text('제조사 : ' + dataList[index].entpname),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
