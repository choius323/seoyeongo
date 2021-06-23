import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'MedicineInfo2.dart';

class DBHelper {
  Database _db;

  DBHelper();

  Future<void> openDB() async {
    // String dbPath = join(await getDatabasesPath(), 'assets/grn_info.db');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, "assets/grn_info.db");

    var exists = await databaseExists(dbPath);

    // if (!exists) {
    // Should happen only the first time you launch your application
    print("Creating new copy from asset");

    // Make sure the parent directory exists
    try {
      await Directory(dirname(dbPath)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", "grn_info.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    await File(dbPath).writeAsBytes(bytes, flush: true);

    // } else {
    //   print("Opening existing database");
    // }

    _db = await openDatabase(
      // 데이터베이스 경로를 지정합니다. 참고: `path` 패키지의 `join` 함수를 사용하는 것이
      // 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법입니다.
      dbPath,
      readOnly: true,
    );
  }

  Future<List<MedicineInfo2>> getDBData(
      {int page, String itemseq, String itemname}) async {
// 모든 MedicineInfo를 얻기 위해 테이블에 질의합니다.
    print('getData method');
    String query = """
        Select * From grn_info 
        Where ITEM_SEQ Like \'\%$itemseq\%\' and
        ITEM_NAME Like \'\%$itemname\%\'
        Limit ?, 15;
        """;
    List args = [
      // itemseq,
      // itemname,
      ((page - 1) * 15 + 1).toString(),
    ];
    var res = await _db.rawQuery(query, args);

    var list = res.isNotEmpty ? mapToList(res) : mapToList(res);
    // print("list" + list.toString());
    return list;
  }

  Future<List<MedicineInfo2>> getDetailData(int id) async {
    print('get detail data');
    var res = await _db.rawQuery("""
    Select * from grn_info
    Where id = ? ;    
    """, [id]);

    var list = res.isNotEmpty ? mapToList(res) : mapToList(res);
    return list;
  }

  List<MedicineInfo2> mapToList(List list) {
    // List<Map<String, dynamic>를 List<MedicineInfo>으로 변환합니다.
    return List.generate(list.length, (i) {
      return MedicineInfo2(
        id: list[i]['ID'],
        itemimage: list[i]['ITEM_IMAGE'],
        itemname: list[i]['ITEM_NAME'],
        entpname: list[i]['ENTP_NAME'],
        itemseq: list[i]['ITEM_SEQ'],
        chart: list[i]["CHART"],
        colorclass1: list[i]["COLOR_CLASS1"],
        colorclass2: list[i]["COLOR_CLASS2"],
        drugshape: list[i]["DRUG_SHAPE"],
        entpseq: list[i]["ENTP_SEQ"],
        markcodeback: list[i]["MARK_CODE_BACK"],
        markcodebackanal: list[i]["MARK_CODE_BACK_ANAL"],
        markcodebackimg: list[i]["MARK_CODE_BACK_IMG"],
        markcodefront: list[i]["MARK_CODE_FRONT"],
        markcodefrontanal: list[i]["MARK_CODE_FRONT_ANAL"],
        markcodefrontimg: list[i]["MARK_CODE_FRONT_IMG"],
        printback: list[i]["PRINT_BACK"],
        printfront: list[i]["PRINT_FRONT"],
      );
    });
  }
}