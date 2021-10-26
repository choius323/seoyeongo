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

    // var exists = await databaseExists(dbPath);

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

  Future<List> getDBData(
      {int page,
      String itemSeq,
      String itemName,
      String itemEnt,
      String itemChart,
      List itemSeqList}) async {
// 모든 MedicineInfo를 얻기 위해 테이블에 질의합니다.
    String query;
    int length;

    print('getData method');
    if (itemSeqList != null) {
      //이미지 분류, 즐겨찾기
      query = "Select * From grn_info Where";
      for (String seq in itemSeqList) {
        query += " ITEM_SEQ Like \'$seq\' or";
      }
      query = query.substring(0, query.length - 2);
    } else {
      //알약 검색
      List chart = itemChart.split(" ");
      query = """
        Select * From grn_info 
        Where ITEM_SEQ Like \'\%$itemSeq\%\'and
          ITEM_NAME Like \'\%$itemName\%\' and
          ENTP_NAME Like \'\%$itemEnt\%\' and
          """;
      for (String c in chart) {
        query += """
        (CHART Like \'\%$c\%\' or
          PRINT_FRONT Like \'\%$c\%\' or
          PRINT_BACK Like \'\%$c\%\' or
          COLOR_CLASS1 Like \'\%$c\%\' or
          COLOR_CLASS2 Like \'\%$c\%\' or
          DRUG_SHAPE Like \'\%$c\%\' or
          MARK_CODE_BACK Like \'\%$c\%\' or
          MARK_CODE_FRONT Like \'\%$c\%\' or
          """;
        query = query.substring(0, query.lastIndexOf("or") - 1);
        query += ") and";
      }
      query = query.substring(0, query.lastIndexOf("and") - 1);
      // CHART Like \'\%$itemChart\%\' or
      // PRINT_FRONT Like \'\%$itemChart\%\' or
      // PRINT_BACK Like \'\%$itemChart\%\' or
      // COLOR_CLASS1 Like \'\%$itemChart\%\' or
      // COLOR_CLASS2 Like \'\%$itemChart\%\' or
      // DRUG_SHAPE Like \'\%$itemChart\%\' or
      // MARK_CODE_BACK Like \'\%$itemChart\%\' or
      // MARK_CODE_FRONT Like \'\%$itemChart\%\'
    }

    String queryLength =
        "Select count(*) as 'count' From (" + query + ") as result";
    var res = await _db.rawQuery(queryLength, []);
    print("res1 : $res");
    length = int.parse(res[0].toString().split(" ")[1].split("}")[0]);
    print("count : $length");

    List args = [
      // itemseq,
      // itemname,
      ((page - 1) * 15).toString(),
    ];

    query += " Limit ?, 15;";
    print("query : " + query);
    res = await _db.rawQuery(query, args);
    print("res2 : " + res.toString());

    // var list = res.isNotEmpty ? mapToList(res) : mapToList(res);
    var list = mapToList(res);
    // print("list" + list.toString());

    print("itemseq : " + list[0].toJson().toString());
    return [list, length];
  }

//   Future<List<MedicineInfo2>> getDBDataSeq(
//       {int page,
//         List seqList}) async {
// // 모든 MedicineInfo를 얻기 위해 테이블에 질의합니다.
//     print('getDBDataSeq method');
//
//     List args = [
//       // itemseq,
//       // itemname,
//       ((page - 1) * 15 + 1).toString(),
//     ];
//     // print(query);
//     var res = await _db.rawQuery(query, args);
//
//     var list = res.isNotEmpty ? mapToList(res) : mapToList(res);
//     // print("list" + list.toString());
//     return list;
//   }

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
        id: list[i]['id'],
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
