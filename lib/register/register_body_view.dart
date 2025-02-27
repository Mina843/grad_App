import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gg/register/register_page_header.dart';
import 'package:gg/register/register_text_field.dart';
import 'package:gg/register/user_have_account.dart';

class RegisterBodyView extends StatelessWidget {
  const RegisterBodyView({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.errorMessage,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 80),
        const RegisterPageHeader(),
        const SizedBox(height: 20),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(60),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 60),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1400),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(225, 95, 27, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: RegisterTextFieldWidget(
                          nameController: nameController,
                          emailController: emailController,
                          passwordController: passwordController),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const UserHaveAccount(),
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1600),
                    child: MaterialButton(
                      onPressed: () {},
                      height: 50,
                      color: Colors.orange[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
