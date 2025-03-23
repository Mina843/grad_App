import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import '../login/login_page.dart';

class ControlPage extends StatefulWidget {
  final BluetoothConnection? connection;
  const ControlPage({super.key, this.connection});

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  bool isArabic = false;

  void showMovementMessage(String direction) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isArabic
              ? (direction == "Forward"
              ? "تحرك للأمام"
              : direction == "Backward"
              ? "تحرك للخلف"
              : direction == "Left"
              ? "تحرك لليسار"
              : direction == "Right"
              ? "تحرك لليمين"
              : "تم التوقف")
              : direction == "Stop"
              ? "Stopped!"
              : "Moving $direction...",
          style: const TextStyle(fontSize: 16),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor:
        direction == "Stop" ? Colors.grey.shade800 : Colors.deepPurpleAccent,
      ),
    );
    sendCommand(direction);
  }

  void sendCommand(String direction) {
    if (widget.connection != null && widget.connection!.isConnected) {
      String command = '';
      switch (direction) {
        case "Forward":
          command = 'o';
          break;
        case "Backward":
          command = 'a';
          break;
        case "Right":
          command = 'i';
          break;
        case "Left":
          command = 'e';
          break;
        case "Stop":
          command = 't';
          break;
      }
      widget.connection!.output.add(Uint8List.fromList(command.codeUnits));
      widget.connection!.output.allSent;
      print("📡 تم إرسال: $command");
    } else {
      print("⚠️ غير متصل بالبلوتوث!");
    }
  }

  void _toggleLanguage(bool arabic) {
    setState(() {
      isArabic = arabic;
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isArabic ? "تحكم في الكرسي المتحرك" : "Wheelchair Control"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => showMovementMessage("Forward"),
                child: Text(isArabic ? "أمام" : "Forward", style: const TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => showMovementMessage("Left"),
                      child: Text(isArabic ? "يسار" : "Left", style: const TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () => showMovementMessage("Stop"),
                    icon: const Icon(Icons.stop, size: 28),
                    label: Text(
                      isArabic ? "إيقاف" : "Stop",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      backgroundColor: Colors.grey.shade800,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      elevation: 5,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => showMovementMessage("Right"),
                      child: Text(isArabic ? "يمين" : "Right", style: const TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => showMovementMessage("Backward"),
                child: Text(isArabic ? "خلف" : "Backward", style: const TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}