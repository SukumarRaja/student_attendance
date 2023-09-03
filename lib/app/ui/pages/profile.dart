import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/database.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dbService = Provider.of<DatabaseService>(context);
    dbService.departments.isEmpty ? dbService.getAllDepartments() : null;
    name.text.isEmpty ? name.text = dbService.user?.name ?? "" : null;
    return Scaffold(
        body: dbService.user == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 80),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.redAccent),
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text("Employee Id : ${dbService.user?.employeeId}"),
                        const SizedBox(
                          height: 30,
                        ),
                        buildTextFormField(
                            label: "Name",
                            icon: Icons.person,
                            controller: name,
                            validator: (data) {
                              if (data == "") {
                                return 'Please enter name';
                              }
                            }),
                        dbService.departments.isEmpty
                            ? const LinearProgressIndicator()
                            : SizedBox(
                                width: double.infinity,
                                child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  value: dbService.employeeDepartment ??
                                      dbService.departments.first.id,
                                  items: dbService.departments.map((e) {
                                    return DropdownMenuItem(
                                        value: e.id,
                                        child: Text(
                                          e.title,
                                          style: const TextStyle(fontSize: 20),
                                        ));
                                  }).toList(),
                                  onChanged: (data) {
                                    dbService.employeeDepartment = data;
                                  },
                                ),
                              ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                dbService.updateProfile(
                                    name: name.text.trim(), context: context);
                              },
                              child: const Text(
                                "Update Profile",
                                style: TextStyle(fontSize: 20),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ));
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
