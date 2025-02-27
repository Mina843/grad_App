import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class RegisterPageHeader extends StatelessWidget {
  const RegisterPageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FadeInUp(
              duration: const Duration(milliseconds: 1000),
              child: const Text(
                "Register",
                style: TextStyle(color: Colors.white, fontSize: 40),
              )),
          const SizedBox(height: 10),
          FadeInUp(
              duration: const Duration(milliseconds: 1300),
              child: const Text(
                "Create a new account",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
        ],
      ),
    );
  }
}
