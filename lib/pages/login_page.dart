import 'package:flutter/material.dart';
import 'package:flutter_project/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  String? email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SafeArea(child: _buildUI(context)),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _title(),
            const SizedBox(
              height: 20,
            ),
            _loginForm(context),
          ],
        ));
  }

  Widget _title() {
    return const Column(children: [
      Text(
        "Login",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        "Login to access your receipe book",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
      )
    ]);
  }

  Widget _loginForm(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.90,
      height: MediaQuery.sizeOf(context).height * 0.30,
      child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email.";
                  }
                },
                onSaved: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.grey[500])),
              ),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return "Password must be longer than 8 character.";
                  }
                },
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                },
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey[500])),
              ),
              const SizedBox(
                height: 5,
              ),
              _loginButton(context),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/signup");
                        },
                        child: const Text("Sign Up here."))
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget _loginButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.60,
      child: ElevatedButton(
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
            // print("$email -> $password");

            bool result = await AuthService().login(email!, password!);
            if (result) {
              Navigator.pushReplacementNamed(context, "/home");
            } else {
              StatusAlert.show(context,
                  duration: const Duration(seconds: 2),
                  title: "Login Failed",
                  subtitle: "Please try again.",
                  configuration: const IconConfiguration(icon: Icons.error),
                  maxWidth: 260);
            }
          }
        },
        child: const Text("Login"),
      ),
    );
  }
}
