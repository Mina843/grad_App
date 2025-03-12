import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HealthFeaturePage extends StatelessWidget {
  const HealthFeaturePage({super.key});

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
          // خلفية الصفحة مع شفافية
          Opacity(
            opacity: 0.3, // تقليل وضوح الصورة لجعل النصوص واضحة
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/health_background.png"), // تأكد من وضع الصورة داخل مجلد assets
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // المحتوى الأساسي
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // مؤشر مستوى الأكسجين
                CircularPercentIndicator(
                  radius: 80.0,
                  lineWidth: 12.0,
                  percent: 0.85,
                  center: const Text(
                    "85%",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  progressColor: Colors.green,
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: Colors.white24,
                  header: const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Oxygen Level",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // مؤشر درجة الحرارة
                CircularPercentIndicator(
                  radius: 80.0,
                  lineWidth: 12.0,
                  percent: 0.75,
                  center: const Text(
                    "37°C",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  progressColor: Colors.red,
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
