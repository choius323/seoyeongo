import 'package:flutter/material.dart';
import 'package:seoyeongo/medicineList.dart';

class SearchMedicine extends StatefulWidget {
  @override
  SearchMedicineState createState() => SearchMedicineState();
}

class SearchMedicineState extends State<SearchMedicine> {
  final mNameController = TextEditingController();
  final mNumController = TextEditingController();
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
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: mNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '의약품 이름',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: mNumController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '의약품 번호',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '제조사',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            OutlinedButton(
              child: Text('검색'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicineList(mNameController.text),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
