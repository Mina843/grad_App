import 'package:flutter/material.dart';
import 'login/login_page.dart'; // تأكد من استيراد صفحة تسجيل الدخول

class ControlPage extends StatefulWidget {
  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  bool isArabic = false; // اللغة الافتراضية هي الإنجليزية

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
          style: TextStyle(fontSize: 16),
        ),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: direction == "Stop" ? Colors.grey.shade800 : Colors.deepPurpleAccent,
      ),
    );
  }

  void _toggleLanguage(bool arabic) {
    setState(() {
      isArabic = arabic;
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // انتقل إلى صفحة تسجيل الدخول
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
              // زر الأمام
              ElevatedButton(
                onPressed: () => showMovementMessage("Forward"),
                child: Text(isArabic ? "أمام" : "Forward",
                    style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 15),

              // صف الأزرار: يسار - توقف - يمين
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // زر اليسار
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => showMovementMessage("Left"),
                      child: Text(isArabic ? "يسار" : "Left",
                          style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  // تباعد بين الأزرار
                  SizedBox(width: 10),

                  // زر التوقف في المنتصف
                  ElevatedButton.icon(
                    onPressed: () => showMovementMessage("Stop"),
                    icon: Icon(Icons.stop, size: 28),
                    label: Text(
                      isArabic ? "إيقاف" : "Stop",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      backgroundColor: Colors.grey.shade800,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      elevation: 5,
                    ),
                  ),

                  // تباعد بين الأزرار
                  SizedBox(width: 10),

                  // زر اليمين
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => showMovementMessage("Right"),
                      child: Text(isArabic ? "يمين" : "Right",
                          style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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

              SizedBox(height: 15),

              // زر الخلف
              ElevatedButton(
                onPressed: () => showMovementMessage("Backward"),
                child: Text(isArabic ? "خلف" : "Backward",
                    style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
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
