/// CHART : "녹색의 원형 필름코팅정"
/// COLOR_CLASS1 : "연두"
/// COLOR_CLASS2 : null
/// DRUG_SHAPE : "원형"
/// ENTP_NAME : "일동제약(주)"
/// ENTP_SEQ : "19540006"
/// ITEM_IMAGE : "https://nedrug.mfds.go.kr/pbp/cmn/itemImageDownload/147426403087300104"
/// ITEM_NAME : "가스디알정50밀리그램(디메크로틴산마그네슘)"
/// ITEM_SEQ : "200808876"
/// MARK_CODE_BACK : null
/// MARK_CODE_BACK_ANAL : null
/// MARK_CODE_BACK_IMG : null
/// MARK_CODE_FRONT : null
/// MARK_CODE_FRONT_ANAL : null
/// MARK_CODE_FRONT_IMG : null
/// PRINT_BACK : null
/// PRINT_FRONT : "IDG"
/// id : 1

class MedicineInfo2 {
  String _chart;
  String _colorclass1;
  dynamic _colorclass2;
  String _drugshape;
  String _entpname;
  String _entpseq;
  String _itemimage;
  String _itemname;
  String _itemseq;
  dynamic _markcodeback;
  dynamic _markcodebackanal;
  dynamic _markcodebackimg;
  dynamic _markcodefront;
  dynamic _markcodefrontanal;
  dynamic _markcodefrontimg;
  dynamic _printback;
  String _printfront;
  int _id;

  String get chart => _chart;

  String get colorclass1 => _colorclass1;

  dynamic get colorclass2 => _colorclass2;

  String get drugshape => _drugshape;

  String get entpname => _entpname;

  String get entpseq => _entpseq;

  String get itemimage => _itemimage;

  String get itemname => _itemname;

  String get itemseq => _itemseq;

  dynamic get markcodeback => _markcodeback;

  dynamic get markcodebackanal => _markcodebackanal;

  dynamic get markcodebackimg => _markcodebackimg;

  dynamic get markcodefront => _markcodefront;

  dynamic get markcodefrontanal => _markcodefrontanal;

  dynamic get markcodefrontimg => _markcodefrontimg;

  dynamic get printback => _printback;

  String get printfront => _printfront;

  int get id => _id;

  MedicineInfo2({
    String chart,
    String colorclass1,
    dynamic colorclass2,
    String drugshape,
    String entpname,
    String entpseq,
    String itemimage,
    String itemname,
    String itemseq,
    dynamic markcodeback,
    dynamic markcodebackanal,
    dynamic markcodebackimg,
    dynamic markcodefront,
    dynamic markcodefrontanal,
    dynamic markcodefrontimg,
    dynamic printback,
    String printfront,
    int id,
  }) {
    _chart = chart;
    _colorclass1 = colorclass1;
    _colorclass2 = colorclass2;
    _drugshape = drugshape;
    _entpname = entpname;
    _entpseq = entpseq;
    _itemimage = itemimage;
    _itemname = itemname;
    _itemseq = itemseq;
    _markcodeback = markcodeback;
    _markcodebackanal = markcodebackanal;
    _markcodebackimg = markcodebackimg;
    _markcodefront = markcodefront;
    _markcodefrontanal = markcodefrontanal;
    _markcodefrontimg = markcodefrontimg;
    _printback = printback;
    _printfront = printfront;
    _id = id;
  }

  MedicineInfo2.fromJson(dynamic json) {
    _chart = json["CHART"];
    _colorclass1 = json["COLOR_CLASS1"];
    _colorclass2 = json["COLOR_CLASS2"];
    _drugshape = json["DRUG_SHAPE"];
    _entpname = json["ENTP_NAME"];
    _entpseq = json["ENTP_SEQ"];
    _itemimage = json["ITEM_IMAGE"];
    _itemname = json["ITEM_NAME"];
    _itemseq = json["ITEM_SEQ"];
    _markcodeback = json["MARK_CODE_BACK"];
    _markcodebackanal = json["MARK_CODE_BACK_ANAL"];
    _markcodebackimg = json["MARK_CODE_BACK_IMG"];
    _markcodefront = json["MARK_CODE_FRONT"];
    _markcodefrontanal = json["MARK_CODE_FRONT_ANAL"];
    _markcodefrontimg = json["MARK_CODE_FRONT_IMG"];
    _printback = json["PRINT_BACK"];
    _printfront = json["PRINT_FRONT"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["CHART"] = _chart;
    map["COLOR_CLASS1"] = _colorclass1;
    map["COLOR_CLASS2"] = _colorclass2;
    map["DRUG_SHAPE"] = _drugshape;
    map["ENTP_NAME"] = _entpname;
    map["ENTP_SEQ"] = _entpseq;
    map["ITEM_IMAGE"] = _itemimage;
    map["ITEM_NAME"] = _itemname;
    map["ITEM_SEQ"] = _itemseq;
    map["MARK_CODE_BACK"] = _markcodeback;
    map["MARK_CODE_BACK_ANAL"] = _markcodebackanal;
    map["MARK_CODE_BACK_IMG"] = _markcodebackimg;
    map["MARK_CODE_FRONT"] = _markcodefront;
    map["MARK_CODE_FRONT_ANAL"] = _markcodefrontanal;
    map["MARK_CODE_FRONT_IMG"] = _markcodefrontimg;
    map["PRINT_BACK"] = _printback;
    map["PRINT_FRONT"] = _printfront;
    map["id"] = _id;
    return map;
  }
}
