import 'package:flutter/material.dart';
import 'control_page.dart'; // صفحة التحكم بالكرسي
import 'login/login_page.dart'; // صفحة تسجيل الدخول

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _currentLanguage = 'ar'; // اللغة الافتراضية العربية

  // دالة تغيير اللغة
  void _changeLanguage(String languageCode) {
    setState(() {
      _currentLanguage = languageCode;
    });
  }

  // نافذة اختيار اللغة
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
        title: Text(isArabic ? 'الكرسي المتحرك الذكي' : 'Smart Wheelchair'),
        backgroundColor: Colors.orange,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'language') {
                _showLanguageDialog(); // فتح نافذة اختيار اللغة
              } else if (value == 'logout') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'language',
                child: Text(isArabic ? 'اللغة' : 'Language'),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Text(isArabic ? 'تسجيل الخروج' : 'Logout'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // عنوان الصفحة
            Text(
              isArabic ? "مرحبًا بك في مشروع الكرسي المتحرك الذكي" : "Welcome to the Smart Wheelchair Project",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // صورة تمثيلية للمشروع
            Image.asset("assets/wheelchair_logo.png", height: 150),

            const SizedBox(height: 20),

            // قائمة المزايا في شكل كروت
            Expanded(
              child: ListView(
                children: [
                  Text(
                    isArabic ? "         مميزات هذا المشروع " : "         Project Features : ",
                    style: const TextStyle(fontSize: 30),
                  ),
                  FeatureCard(
                    title: isArabic ? "✨ التحكم الذكي" : "✨ Smart Control",
                    description: isArabic
                        ? "تحكم سلس عبر الهاتف باستخدام الأزرار أو الأوامر الصوتية او بالإشارات العصبية أو باستخدام هذا التطبيق"
                        : "Seamless control via phone using buttons, voice commands, neural signals, or this app.",
                    icon: Icons.phonelink,
                  ),
                  FeatureCard(
                    title: isArabic ? "🚀 مستشعرات دقيقة" : "🚀 Accurate Sensors",
                    description: isArabic ? "قياس مستوى الأكسجين والنبض بدقة عالية" : "Accurately measure oxygen level and pulse.",
                    icon: Icons.monitor_heart,
                  ),
                  FeatureCard(
                    title: isArabic ? "🛑 تجنب العوائق" : "🛑 Obstacle Avoidance",
                    description: isArabic ? "استخدام مستشعرات لعدم الاصطدام بالعوائق أثناء الحركة" : "Using sensors to avoid obstacles while moving.",
                    icon: Icons.sensors,
                  ),
                  FeatureCard(
                    title: isArabic ? "🔔 تنبيه الطوارئ" : "🔔 Emergency Alert",
                    description: isArabic ? "زر طوارئ للإبلاغ عن أي مشكلة بسرعة" : "Emergency button to quickly report any issue.",
                    icon: Icons.emergency,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // زر الانتقال إلى صفحة التحكم
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ControlPage()));
              },
              child: Text(isArabic ? "🚀 انتقل إلى التحكم" : "🚀 Go to Control"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ويدجيت لإظهار كل ميزة بشكل أنيق داخل كارت
class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  FeatureCard({super.key, required this.title, required this.description, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}
