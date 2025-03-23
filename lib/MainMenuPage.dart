import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HealthFeaturePage.dart';
import 'control_page.dart';
import 'login/login_page.dart';
import 'home_page.dart';
import 'BluetoothPage.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class MainMenuPage extends StatefulWidget {
  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  String _currentLanguage = 'en'; // اللغة الافتراضية إنجليزية
  bool _isBluetoothConnected = false;

  void _changeLanguage(String languageCode) {
    setState(() {
      _currentLanguage = languageCode;
    });
  }

  Future<void> _checkBluetoothConnection() async {
    try {
      var bluetooth = FlutterBluetoothSerial.instance;
      List<BluetoothDevice> devices = await bluetooth.getBondedDevices();

      for (var device in devices) {
        if (device.isConnected) {
          setState(() {
            _isBluetoothConnected = true;
          });
          return;
        }
      }
    } catch (e) {
      print("⚠️ خطأ أثناء التحقق من البلوتوث: $e");
    }
    setState(() {
      _isBluetoothConnected = false;
    });
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_currentLanguage == 'ar' ? 'اختر اللغة' : 'Choose Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('English'),
                onTap: () {
                  _changeLanguage('en');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('العربية'),
                onTap: () {
                  _changeLanguage('ar');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = _currentLanguage == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isArabic ? 'القائمة الرئيسية' : 'Main Menu',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.bluetooth, color: _isBluetoothConnected ? Colors.green : Colors.white),
          onPressed: () async {
            await _checkBluetoothConnection();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BluetoothPage()),
            );
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Language') {
                _showLanguageDialog();
              } else if (value == 'Wheelchair Info') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              } else if (value == 'Logout') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Language',
                child: Text(isArabic ? 'اللغة' : 'Language'),
              ),
              PopupMenuItem(
                value: 'Wheelchair Info',
                child: Text(isArabic ? 'معلومات الكرسي المتحرك' : 'Wheelchair Information'),
              ),
              PopupMenuItem(
                value: 'Logout',
                child: Text(isArabic ? 'تسجيل الخروج' : 'Logout'),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton(
                        context: context,
                        label: isArabic ? 'التحكم في الكرسي' : 'Wheelchair Control',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ControlPage()),
                          );
                        },
                        color: Colors.blueAccent,
                      ),
                      SizedBox(height: 20),
                      _buildButton(
                        context: context,
                        label: isArabic ? 'الميزات الصحية' : 'Health Feature',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HealthFeaturePage()),
                          );
                        },
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: _buildButton(
                  context: context,
                  label: isArabic ? 'إغلاق' : 'Close',
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
