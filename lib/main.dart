import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: Text('TFLite Example'),
                backgroundColor: Colors.transparent),
            body: Center(child: MyImagePicker())));
  }
}

class MyImagePicker extends StatefulWidget {
  @override
  MyImagePickerState createState() => MyImagePickerState();
}

class MyImagePickerState extends State {
  File imageURI;
  String result;
  String path;

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imageURI = image;
      path = image.path;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageURI = image;
      path = image.path;
    });
  }

  Future classifyImage(path3) async {
    // 여기가 모델 실행 부분   나머지는 사진 입력+불러오기
    await Tflite.loadModel(
        // pubsepc.yaml 파일에 모델,레이블 파일 등록
        model: "assets/model2.tflite",
        labels:
            "assets/labels.txt"); // model, labels 는 assets 폴더에 모델 (*.tflite) 이랑, 클래스별 텍스트 파일 넣은거 씀

    var output = await Tflite.runModelOnImage(
        //모델에 찍은 이미지 넣고 돌림
        //binary: imageURI,
        path: path3,
        numResults: 25,
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.5);
    // Uint8List imageToByteListFloat32(Image image, int inputSize) {
    //   var convertedBytes = Uint8List(1 * inputSize * inputSize * 3);
    //   var buffer = Uint8List.view(convertedBytes.buffer);
    //   int pixelIndex = 0;
    //   for (var i = 0; i < inputSize; i++) {
    //     for (var j = 0; j < inputSize; j++) {
    //       var pixel = image.getPixel(j, i);
    //       buffer[pixelIndex++] = image.getRed(pixel);
    //       buffer[pixelIndex++] = image.getGreen(pixel);
    //       buffer[pixelIndex++] = image.getBlue(pixel);
    //     }
    //   }
    // }

    setState(() {
      result = output.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          imageURI == null
              ? Text('No image selected.')
              : Image.file(imageURI,
                  width: 224.0, height: 224.0, fit: BoxFit.cover),
          Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
              child: ElevatedButton(
                onPressed: () => getImageFromCamera(),
                child: Text('Click Here To Select Image From Camera'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.fromLTRB(12, 12, 12, 12)),
              )),
          Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: ElevatedButton(
                onPressed: () => getImageFromGallery(),
                child: Text('Click Here To Select Image From Gallery'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.fromLTRB(12, 12, 12, 12)),
              )),
          Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
              child: ElevatedButton(
                onPressed: () => classifyImage(imageURI.path),
                child: Text('Classify Image'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.fromLTRB(12, 12, 12, 12)),
              )),
          result == null ? Text('Result') : Text(result)
        ])));
  }
}
