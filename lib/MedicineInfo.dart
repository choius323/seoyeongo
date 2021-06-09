class MedicineInfo {
  final String image;
  final String mName;
  final String cName;
  final int mNum;

  MedicineInfo(this.image, this.mName, this.cName, this.mNum);

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'mName': mName,
      'nameCom': cName,
      'mNum': mNum,
    };
  }

  @override
  String toString() {
    return 'MedicineInfo(image:$image, mName: $mName, cName:$cName, mNum:$mNum)';
  }
}