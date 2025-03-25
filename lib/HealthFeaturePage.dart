import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HealthFeaturePage extends StatefulWidget {
  const HealthFeaturePage({super.key});

  @override
  _HealthFeaturePageState createState() => _HealthFeaturePageState();
}

class _HealthFeaturePageState extends State<HealthFeaturePage> {
  double heartRate = 0.0; // معدل النبض
  double temperature = 0.0; // درجة الحرارة
  BluetoothConnection? connection;

  @override
  void initState() {
    super.initState();
    connectToBluetooth();
  }

  void connectToBluetooth() async {
    try {
      List<BluetoothDevice> devices = await FlutterBluetoothSerial.instance.getBondedDevices();
      for (var device in devices) {
        if (device.name == "HC-05") { // ضع هنا اسم جهاز البلوتوث الخاص بك
          BluetoothConnection.toAddress(device.address).then((conn) {
            setState(() => connection = conn);
            readData();
          }).catchError((error) {
            print("فشل الاتصال: $error");
          });
          break;
        }
      }
    } catch (e) {
      print("خطأ في البحث عن الأجهزة: $e");
    }
  }

  void readData() {
    if (connection == null) return;

    connection!.input!.listen((Uint8List data) {
      String receivedData = String.fromCharCodes(data);
      List<String> values = receivedData.trim().split(',');

      if (values.length == 2) {
        setState(() {
          heartRate = double.tryParse(values[0]) ?? 0.0; // قراءة النبض
          temperature = double.tryParse(values[1]) ?? 0.0; // قراءة الحرارة
        });
      }
    }).onDone(() {
      print("تم قطع الاتصال بالبلوتوث");
    });
  }

  @override
  void dispose() {
    connection?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Health Feature",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/health_background.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // مؤشر معدل نبضات القلب
                CircularPercentIndicator(
                  radius: 80.0,
                  lineWidth: 12.0,
                  percent: (heartRate / 200).clamp(0.0, 1.0), // نطاق 0-200 نبضة
                  center: Text(
                    "${heartRate.toStringAsFixed(1)} BPM",
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  progressColor: Colors.red,
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: Colors.white24,
                  header: const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Heart Rate",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // مؤشر درجة الحرارة
                CircularPercentIndicator(
                  radius: 80.0,
                  lineWidth: 12.0,
                  percent: ((temperature - 30) / 10).clamp(0.0, 1.0),
                  center: Text(
                    "${temperature.toStringAsFixed(1)}°C",
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  progressColor: Colors.blue,
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: Colors.white24,
                  header: const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Temperature",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
