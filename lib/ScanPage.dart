import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  List<CameraDescription>? cameras;
  CameraController? _cameraController;
  bool _isRearCameraSelected = true;

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getCamera();
  }

  void getCamera() async {
    await availableCameras().then((value) {
      cameras = value;
      initCamera(value[0]);
    });
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController?.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String tdata = DateFormat("HH:mm:ss").format(DateTime.now());

    return Scaffold(
        body: Stack(children: [
      (_cameraController != null && _cameraController!.value.isInitialized)
          ? SizedBox(
              width: size.width,
              height: size.height,
              child: CameraPreview(_cameraController!),
            )
          : Container(
              color: Colors.black,
              child: const Center(child: CircularProgressIndicator())),
      //Top layout
      Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.20,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                height: 55,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6)),
                  color: Colors.white,
                ),
                child: const Text(
                  "Company ABC",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              )),
              Container(
                width: 1,
                height: 55,
                color: Colors.grey,
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                height: 55,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomRight: Radius.circular(6)),
                  color: Colors.white,
                ),
                child: Text(
                  tdata,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              )),
              const SizedBox(
                width: 20,
              ),
            ]),
          )),
      // Scan layout
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: Container(
            alignment: Alignment.center,
            height: 40,
            width: 110,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.document_scanner),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Scan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
      // Face scan rect area
      Align(
        alignment: Alignment.center,
        child: Container(
          child: Image.asset("assets/scan_border.png"),
        )
        /*Container(
          height: 400,
          width: 300,

          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                      child: Container(
                        color: Colors.green,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
                      child: Container(
                        color: Colors.green,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.fromBorderSide(BorderSide(color: Colors.white,width: 2)),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
                    ),
                  ),
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
                      child: Container(
                        color: Colors.green,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        )*/
        ,
      )
    ]));
  }
}
