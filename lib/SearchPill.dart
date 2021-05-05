import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SearchPill extends StatefulWidget {
  @override
  State createState() => SearchPillState();
}

class SearchPillState extends State<SearchPill> {
  bool camPermissionsGranted = false;
  List<CameraDescription> cameras;
  CameraController _controller;
  Future<void> initController;

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
    _controller = new CameraController(cameras.first, ResolutionPreset.medium);
    initController = _controller.initialize();

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
    if (camPermissionsGranted) {
      // && !controller.value.isInitialized
      return Scaffold(
          appBar: AppBar(
            title: Text('낱알 검색'),
          ),
          body: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                      height: 550,
                      width: 450,
                      child: FutureBuilder<void>(
                        future: initController,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            //  Future 가 완료되면 미리보기 보여준다.
                            return CameraPreview(_controller);
                          } else {
                            // 아니면 로딩 표시를 한다.
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      )),
                  // Text('Stack'),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 200),
                        Container(
                          width: 150,
                          height: 150,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.orangeAccent, width: 6)),
                        )
                      ],
                    ),

                    // child: CustomPaint(
                    //   painter: RectPainter(),
                    // ),
                    // alignment: Alignment.center,
                  ),
                ],
              )
            ],
          ));
    } else {
      return Container(
        child: AlertDialog(
          content: Text('카메라 권한이 필요합니다.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text('닫기'))
          ],
        ),
      );
    }
  }
}

// class RectPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint rect = Paint()
//       ..color = Color(0xff000000)
//       ..style = PaintingStyle.fill;
//
//     Offset offset = Offset(size.width / 2, size.height / 2);
//     canvas.drawRect(offset & Size(200, 200), rect);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
