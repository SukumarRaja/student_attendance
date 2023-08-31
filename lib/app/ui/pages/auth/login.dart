import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            height: height / 3,
            width: width,
            decoration: const BoxDecoration(
                color: Colors.redAccent,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(70))),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                  size: 60,
                ),
                SizedBox(height: 15),
                Text(
                  "Attendances",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Form(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  buildTextFormField(
                      label: "Email",
                      icon: Icons.person,
                      controller: email,
                      validator: (data) {
                        if (data == "") {
                          return 'Please enter email';
                        }
                      }),
                  buildTextFormField(
                      label: "Password",
                      icon: Icons.lock,
                      controller: password,
                      obSecure: true,
                      validator: (data) {
                        if (data == "") {
                          return 'Please enter password';
                        }
                      }),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20),
                )),
          )
        ],
      ),
    );
  }

  buildTextFormField({icon, label, controller, validator, obSecure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        validator: validator,
        decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              // borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                    // color:
                    ))),
        controller: controller,
        obscureText: obSecure,
      ),
    );
  }
}
