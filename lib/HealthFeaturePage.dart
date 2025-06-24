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
  double heartRate = 0.0;
  double temperature = 0.0;
  BluetoothConnection? connection;
  String buffer = '';

  @override
  void initState() {
    super.initState();
    connectToBluetooth();
  }

  void connectToBluetooth() async {
    try {
      List<BluetoothDevice> devices = await FlutterBluetoothSerial.instance.getBondedDevices();
      for (var device in devices) {
        if (device.name == "HC-05") {
          BluetoothConnection.toAddress(device.address).then((conn) {
            setState(() => connection = conn);
            print("✅ تم الاتصال بـ HC-05");
            readData();
          }).catchError((error) {
            print("❌ فشل الاتصال: $error");
          });
          break;
        }
      }
    } catch (e) {
      print("❌ خطأ في البلوتوث: $e");
    }
  }

  void readData() {
    connection?.input?.listen((Uint8List data) {
      buffer += String.fromCharCodes(data);

      if (buffer.contains('\n')) {
        List<String> lines = buffer.split('\n');
        for (var line in lines.sublist(0, lines.length - 1)) {
          parseData(line.trim());
        }
        buffer = lines.last;
      }
    }).onDone(() {
      print("🔌 تم قطع الاتصال");
    });
  }

  void parseData(String data) {
    List<String> values = data.split(',');
    if (values.length == 2) {
      setState(() {
        heartRate = double.tryParse(values[0]) ?? 0.0;
        temperature = double.tryParse(values[1]) ?? 0.0;
      });
    }
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
        title: const Text("🩺 Health Feature (Bluetooth)"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 80.0,
              lineWidth: 12.0,
              percent: (heartRate / 200).clamp(0.0, 1.0),
              center: Text(
                "${heartRate.toStringAsFixed(1)} BPM",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              progressColor: Colors.red,
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.black12,
              header: const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text("❤️ Heart Rate", style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 40),
            CircularPercentIndicator(
              radius: 80.0,
              lineWidth: 12.0,
              percent: ((temperature - 30) / 10).clamp(0.0, 1.0),
              center: Text(
                "${temperature.toStringAsFixed(1)} °C",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              progressColor: Colors.blue,
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.black12,
              header: const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text("🌡️ Temperature", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
