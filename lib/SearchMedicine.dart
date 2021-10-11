import 'package:flutter/material.dart';
import 'package:seoyeongo/medicineList.dart';

import 'medicineListDB.dart';

class SearchMedicine extends StatefulWidget {
  @override
  SearchMedicineState createState() => SearchMedicineState();
}

class SearchMedicineState extends State<SearchMedicine> {
  final itemNameController = TextEditingController();
  final itemSeqController = TextEditingController();
  final itemEntController = TextEditingController();
  final itemChartController = TextEditingController();
  final textC = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('의약품 검색'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            TextField(
              controller: itemNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '의약품 이름',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: itemSeqController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '의약품 번호',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: itemEntController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '제조사',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: itemChartController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '글자, 모양, 색',
              ),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              child: Text('검색'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MedicineList(itemNameController.text),
                    ));
              },
            ),
            OutlinedButton(
              child: Text('내장 DB 검색'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicineListDB(
                        itemSeq: itemSeqController.text,
                        itemName: itemNameController.text,
                        itemEnt: itemEntController.text,
                        itemChart: itemChartController.text,
                      ),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
