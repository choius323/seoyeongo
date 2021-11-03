import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import 'medicineListDB.dart';

class SearchPill extends StatefulWidget {
  SearchPill({Key key}) : super(key: key);

  @override
  State createState() => SearchPillState();
}

class SearchPillState extends State<SearchPill> {
  bool camPermissionsGranted = false;
  List<CameraDescription> cameras;

  File _imageFile;

  List result;

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width / 1.5;
    // final height = MediaQuery.of(context).size.height / 1.5;

    // if (camPermissionsGranted) {
    //   // && !controller.value.isInitialized
    return Scaffold(
        appBar: AppBar(
          title: Text("낱알 검색"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _imageFile == null
                  ? Text(
                      '사진을 선택해주세요.\n사각형에 딱 맞을수록 더 정확한 결과가 나옵니다.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    )
                  : Image.file(_imageFile,
                      // width: 300.0,
                      height: 224.0),
              // takePictureButton(context),
              OutlinedButton(
                  onPressed: () => _loadImage(ImageSource.camera),
                  child: Text(
                    "사진 촬영",
                    style: TextStyle(fontSize: 25),
                  )),
              OutlinedButton(
                  onPressed: () {
                    _loadImage(ImageSource.gallery);
                  },
                  child: Text(
                    '사진 불러오기',
                    style: TextStyle(fontSize: 25),
                  )),
              OutlinedButton(
                  onPressed: () => classifyImage(_imageFile.path),
                  child: Text(
                    '이미지 분류',
                    style: TextStyle(fontSize: 25),
                  )),
              OutlinedButton(
                  onPressed: () {
                    print(_imageFile.path);
                    GallerySaver.saveImage(_imageFile.path)
                        .then((value) => print('>>>> save value= $value'))
                        .catchError((err) {
                      print('error :( $err');
                    });
                  },
                  child: Text(
                    '이미지 저장',
                    style: TextStyle(fontSize: 25),
                  )),
              // Text(result == null ? 'result' : result.toString()),
            ],
          ),
        ));
  }

  _loadImage(ImageSource source) async {
    // 갤러리에서 사진 불러오기
    PickedFile picker = await ImagePicker().getImage(source: source);

    //가져온 사진의 Type을 File 형식으로 바꿔줍니다.
    File _imageFile = File(picker.path);

    this.setState(() {
      _cropImage(_imageFile);
    });
  }

  _cropImage(File picked) async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: picked.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (cropped != null) {
      this.setState(() {
        _imageFile = cropped;
      });
    }
  }

  Future classifyImage(path3) async {
    // 여기가 모델 실행 부분   나머지는 사진 입력+불러오기
    List list = [];
    await Tflite.loadModel(
      // pubsepc.yaml 파일에 모델,레이블 파일 등록
      model: "assets/pill_100_Mo2_40.tflite",
      labels: "assets/labels.txt",
    ); // model, labels 는 assets 폴더에 모델 (*.tflite) 이랑, 클래스별 텍스트 파일 넣은거 씀

    var output = await Tflite.runModelOnImage(
      //모델에 찍은 이미지 넣고 돌림
      //binary: imageURI,
      path: path3,
      numResults: 15,
      imageMean: 127.5,
      imageStd: 127.5,
      threshold: 0.0,
    );

    // print("output : ${output.toList().map((e) => list.add(e['label']))}");
    list = output
        .toList()
        .map((e) => e['label'].toString().split(' ')[1])
        .toList();
    setState(() {
      print("result :" + result.toString());
      result = list;
    });

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MedicineListDB(
            searchType: MedicineListDB.SEARCH_PILL,
            itemSeqList: result,
          ),
        ));

    await Tflite.close();
  }
}
