class MedicineInfo2 {
  final String image;
  final String mName;
  final String eName;
  final String mNum;

  const MedicineInfo2({this.image, this.mName, this.eName, this.mNum});

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'mName': mName,
      'nameCom': eName,
      'mNum': mNum,
    };
  }

  @override
  String toString() {
    return 'MedicineInfo(image:$image, mName: $mName, cName:$eName, mNum:$mNum)';
  }
}