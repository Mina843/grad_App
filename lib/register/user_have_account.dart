import 'package:flutter/material.dart';

class UserHaveAccount extends StatelessWidget {
  const UserHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Login',
            style: TextStyle(color: Colors.orange[900]),
          ),
        ),
      ],
    );
  }
}
