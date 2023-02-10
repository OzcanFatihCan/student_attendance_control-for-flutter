import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer';
import 'dart:io';

class qrPageScreen extends StatefulWidget {
  const qrPageScreen({super.key});

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<qrPageScreen> {
  Barcode? result;
  QRViewController? qrControl;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrControl!.pauseCamera();
    } else if (Platform.isIOS) {
      qrControl!.resumeCamera();
    }
  }

  @override
  void dispose() {
    super.dispose();
    qrControl?.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      qrControl = controller;
    });
    qrControl!.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: _buildQrView(context),
          ),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Kamera Kontrolcüsü"),
                      Container(
                        margin: const EdgeInsets.all(2),
                        child: IconButton(
                          onPressed: () async {
                            await qrControl?.pauseCamera();
                          },
                          icon: new Icon(
                            MdiIcons.pause,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: IconButton(
                          onPressed: () async {
                            await qrControl?.resumeCamera();
                          },
                          icon: new Icon(
                            MdiIcons.play,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                  if (result != null)
                    Text(
                      '${result!.code}',
                    )
                  else
                    const Text(
                        "Belirtilen alana ortalanacak şekilde qr kodunu hizalayın"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 350.0
        : 700.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }
}
