import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
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
                labelText: '글자, 모양, 색 (띄어쓰기로 여러개 구분 입력)',
                hintText: "흰색 타원형 분할선",
                hintStyle: TextStyle(color: Color.fromARGB(150, 102, 102, 102)),
              ),
            ),
            SizedBox(height: 10),
            // OutlinedButton(
            //   child: Text('검색'),
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) =>
            //               MedicineList(itemNameController.text),
            //         ));
            //   },
            // ),
            OutlinedButton(
              child: Text('검색'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicineListDB(
                        searchType: MedicineListDB.SEARCH_MEDICINE,
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
