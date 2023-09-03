import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            height: height / 4,
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
                  // buildTextFormField(
                  //     label: "Name",
                  //     icon: Icons.person,
                  //     controller: email,
                  //     validator: (data) {
                  //       if (data == "") {
                  //         return 'Please enter name';
                  //       }
                  //     }),
                  buildTextFormField(
                      label: "Email",
                      icon: Icons.email,
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
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Consumer<AuthService>(
              builder: (context, auth, child) {
                return SizedBox(
                  width: double.infinity,
                  child: auth.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            auth.register(
                                email: email.text.trim(),
                                password: password.text.trim(),
                                context: context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: const Text(
                            "Register",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                );
              },
            ),
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
