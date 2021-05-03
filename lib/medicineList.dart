import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seoyeongo/viewDetail.dart';

class medicineList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('검색 결과'),
      ),
      body: Container(child: UsingBuilderListConstructing()),
    );
  }
}

class MedicineInfo {
  String image;
  String name;
  String nameCom;
  int number;

  MedicineInfo(this.image, this.name, this.nameCom, this.number);
}

class UsingBuilderListConstructing extends StatelessWidget {
  List med = <MedicineInfo>[];

  @override
  Widget build(BuildContext context) {
    List images = <String>[
      "images/201407280003901.jpg",
      "images/A11AJJJJJ003201.jpg",
      "images/A11AKP08F000701.jpg",
      "images/A11AOOOOO358301.jpg"
    ];
    for (int i = 0; i < 30; i++) {
      med.add(MedicineInfo(images[i % 4], "$i 이름", "$i 회사", i));
    }

    var _listView = ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewDetail(med[index].image, med[index].number)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  med[index].image,
                  width: 40 * MediaQuery.of(context).size.width / 100,
                ),
                Column(
                  children: [
                    Text(med[index].name),
                    Text(med[index].nameCom),
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: med.length);

    var _medicineTile = Container(
      child: Row(
        children: [],
      ),
    );

    return Container(
      child: _listView,
    );
  }
}
