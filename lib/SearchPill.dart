import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'CropperTest.dart';

class SearchPill extends StatefulWidget {
  SearchPill({Key key}) : super(key: key);

  @override
  State createState() => SearchPillState();
}

class SearchPillState extends State<SearchPill> {
  bool camPermissionsGranted = false;
  List<CameraDescription> cameras;
  CameraController _controller;
  Future<void> _initController;
  File _imageFile;

  @override
  void initState() {
    super.initState();
    setupCameras();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> setupCameras() async {
    // checkPermission();

    cameras = await availableCameras();
    _controller = new CameraController(cameras.first, ResolutionPreset.high);
    _initController = _controller.initialize();

    if (await Permission.camera.request().isGranted) {
      setState(() {
        camPermissionsGranted = true;
      });
    }

    //여러가지 퍼미션을하고싶으면 []안에 추가하면된다. (팝업창이뜬다)
    Map<Permission, PermissionStatus> statuses =
        await [Permission.camera].request();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 1.5;
    final height = MediaQuery.of(context).size.height / 1.5;

    if (camPermissionsGranted) {
      // && !controller.value.isInitialized
      return Scaffold(
          appBar: AppBar(
            title: Text('낱알 검색'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                takePictureButton(context),
                OutlinedButton(
                    onPressed: () => _loadImage(ImageSource.camera),
                    child: Text(
                      "사진 촬영2",
                      style: TextStyle(fontSize: 25),
                    )),
                OutlinedButton(
                    onPressed: () {
                      _loadImage(ImageSource.gallery);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => DisplayPictureScreen(
                      //       imagePath: _imageFile,
                      //     ),
                      //   ),
                      // );
                    },
                    child: Text(
                      '사진 불러오기',
                      style: TextStyle(fontSize: 25),
                    )),
                OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CropperTest()));
                    },
                    child: Text('crop image')),
              ],
            ),
          ));
    } else {
      return Container(
        child: AlertDialog(content: Text('카메라 권한이 필요합니다.'), actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('닫기'))
        ]),
      );
    }
  }

  Widget takePictureButton(context) {
    return OutlinedButton(
        onPressed: () async {
          // try / catch 블럭에서 사진을 촬영
          try {
            // 카메라 초기화가 완료됐는지 확인
            await _initController;

            // path 패키지를 사용하여 이미지가 저장될 경로를 지정합니다.
            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            // 사진 촬영을 시도하고 저장되는 경로를 로그로 남깁니다.
            await _controller.takePicture(path);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: File(path),
                ),
              ),
            );
          } catch (e) {
            // 만약 에러가 발생하면, 콘솔에 에러 로그를 남깁니다.
            print(e);
          }
        },
        child: Text(
          '사진 촬영',
          style: TextStyle(fontSize: 25),
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
        maxHeight: 700,
        maxWidth: 700,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
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
}

// 사용자가 촬영하거나 불러온 사진을 보여주는 위젯(화면)
class DisplayPictureScreen extends StatelessWidget {
  final File imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File file = imagePath;
    return Scaffold(
        appBar: AppBar(title: Text('사진')),
        // 이미지는 디바이스에 파일로 저장됩니다. 이미지를 보여주기 위해 주어진
        // 경로로 `Image.file`을 생성하세요.
        body: Container(
          alignment: Alignment.topCenter,
          width: 300,
          margin: EdgeInsets.all(50),
          child: file == null ? Text('file == null') : Image.file(file),
          // child: Image.file(File(imagePath), fit: BoxFit.contain),
        ));
  }
}
