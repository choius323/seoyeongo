import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class medicineList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('검색결과'),
      ),
      body: Container(
        child: UsingBuilderListConstructing()
      ),
    );
  }
}

class MedicineInfo {
  Image image;
  String name;
  String nameCom;

  MedicineInfo(this.image, this.name, this.nameCom);
}

class UsingBuilderListConstructing extends StatelessWidget {
  var med = <MedicineInfo>[];

  @override
  Widget build(BuildContext context) {
    med.add(MedicineInfo(Image.asset("imgs/201407280003901.jpg",), "1", "1"));
    med.add(MedicineInfo(null, "1", "1"));
    med.add(MedicineInfo(null, "1", "1"));
    med.add(MedicineInfo(null, "1", "1"));

    var _listView = ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            // child: Text(med[index].name + med[index].nameCom),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("imgs/A11AJJJJJ003201.jpg"),
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
        children: [
        ],
      ),
    );

    return Container(
      child: _listView,
    );
  }
}