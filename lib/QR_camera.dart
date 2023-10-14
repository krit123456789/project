import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/select_category.dart';
import 'package:project/select_supplies.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class QRCamera extends StatefulWidget {
  @override
  _QRCameraState createState() => _QRCameraState();
}

class _QRCameraState extends State<QRCamera> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4c1130),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
        ],
      ),
    );
  }

  @override
  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderRadius: 5,
          borderWidth: 10,
          borderLength: 10,
          borderColor: Colors.white,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        String? data = result!.code;
        if (data != null) {
          controller.pauseCamera();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectSupplies(
                id: scanData.code!,
              ),
            ),
          ).then((value) => controller.resumeCamera());
        }
      });
    });
  }
}
