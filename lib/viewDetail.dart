import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewDetail extends StatelessWidget {
  String medicineNum;
  num number;

  ViewDetail(this.medicineNum, this.number);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('검색 결과'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Image.asset(
                // "images/$medicineNum.jpg",
                medicineNum,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              alignment: Alignment.topCenter,
            ),
            Text("의약품 코드 : $medicineNum"),
            Text("번호 : $number"),
            Text("의약품 코드 : $medicineNum"),
            Text("번호 : $number"),
            Text("의약품 코드 : $medicineNum"),
            Text("번호 : $number"),
            Text("의약품 코드 : $medicineNum"),
            Text("번호 : $number"),
            Text("의약품 코드 : $medicineNum"),
            Text("번호 : $number"),
            Text("의약품 코드 : $medicineNum"),
            Text("번호 : $number"),
            Text("의약품 코드 : $medicineNum"),
            Text("번호 : $number"),
            Text("의약품 코드 : $medicineNum"),
            Text("번호 : $number"),
            Text("의약품 코드 : $medicineNum"),
            Text("번호 : $number"),
            Text("의약품 코드 : $medicineNum"),
            Text("번호 : $number"),
            Text("의약품 코드 : $medicineNum"),
            Text("번호 : $number"),
            Text("의약품 코드 : $medicineNum"),
            Text("번호 : $number"),
            Text("의약품 코드 : $medicineNum"),
            Text("번호 : $number"),
          ],
        ),
      ),
    );
  }
}
