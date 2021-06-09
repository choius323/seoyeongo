import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'MedicineInfo.dart';

class LoadDB {
  var db;
  String itemSeq;

  LoadDB(String itemSeq);

  Future<void> OpenDB() async {
    // 데이터베이스를 열고 참조 값을 얻습니다.
    db = openDatabase(
      // 데이터베이스 경로를 지정합니다. 참고: `path` 패키지의 `join` 함수를 사용하는 것이
      // 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법입니다.
      join(await getDatabasesPath(), 'assets/grn_info_db.sqlite'),
      readOnly: true,
    );

  }

  Future<List<MedicineInfo>> getData() async {
// 모든 MedicineInfo를 얻기 위해 테이블에 질의합니다.
  print('getData method');
    final List<Map<String, dynamic>> maps = await db.query(
        'Select ITEM_SEQ, ITEM_NAME, ENTP_NAME, ITEM_IMAGE grn_info'
        'Where ITEM_SEQ Like \'\%20080\%\'; ',
        // whereArgs: [itemSeq]
    );
    print(maps);
    // List<Map<String, dynamic>를 List<MedicineInfo>으로 변환합니다.
    return List.generate(maps.length, (i) {
      return MedicineInfo(
        maps[i]['ITEM_IMAGE'],
        maps[i]['ITEM_NAME'],
        maps[i]['ENTP_NAME'],
        maps[i]['ITEM_SEQ'],
      );
    });
  }
}
