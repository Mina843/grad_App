import 'package:flutter/material.dart';
import 'control_page.dart'; // صفحة التحكم بالكرسي

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الكرسي المتحرك الذكي'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // عنوان الصفحة
            const Text(
              "مرحبًا بك في مشروع الكرسي المتحرك الذكي",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // صورة تمثيلية للمشروع
            Image.asset("assets/wheelchair_logo.png", height: 150),

            const SizedBox(height: 20),

            // قائمة المزايا في شكل كروت
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    "        : مميزات هذا المشروع ",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  FeatureCard(
                    title: "✨ التحكم الذكي",
                    description:
                        "تحكم سلس عبر الهاتف باستخدام الأزرار أو الأوامر الصوتية او بالاشارت العصبيةاو باستخدام هذا التطبيق.",
                    icon: Icons.phonelink,
                  ),
                  FeatureCard(
                    title: "🚀 مستشعرات دقيقة",
                    description: "قياس مستوى الأكسجين والنبض بدقة عالية.",
                    icon: Icons.monitor_heart,
                  ),
                  FeatureCard(
                    title: "🛑 تجنب العوائق",
                    description:
                        "استخدام مستشعرات لعدم الاصطدام بالعوائق أثناء الحركة.",
                    icon: Icons.sensors,
                  ),
                  FeatureCard(
                    title: "🔔 تنبيه الطوارئ",
                    description: "زر طوارئ للإبلاغ عن أي مشكلة بسرعة.",
                    icon: Icons.emergency,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // زر الانتقال إلى صفحة التحكم
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ControlPage()));
              },
              child: const Text("🚀 انتقل إلى التحكم"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  FeatureCard(
      {super.key,
      required this.title,
      required this.description,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.blue),
        title: Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}
