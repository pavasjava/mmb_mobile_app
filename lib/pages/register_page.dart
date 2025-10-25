import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fnameController = TextEditingController();
  final TextEditingController mnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool emailExistsError = false;

  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse("http://localhost:3399/api/register");
      // ⚠️ Use 10.0.2.2 for Android emulator
      // Replace with your PC’s IP if running on real device

      final body = jsonEncode({
        "fname": fnameController.text.trim(),
        "mname": mnameController.text.trim(),
        "lname": lnameController.text.trim(),
        "mobile": mobileController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      });

      try {
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: body,
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data["message"] ?? "Registration successful"),
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else if (response.statusCode == 409) {
          setState(() {
            emailExistsError = true;
          });
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error: ${response.body}")));
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 191, 191),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),

                  if (emailExistsError)
                    const Text(
                      "Email already exists!",
                      style: TextStyle(color: Colors.red),
                    ),

                  const SizedBox(height: 10),

                  TextFormField(
                    controller: fnameController,
                    decoration: const InputDecoration(
                      labelText: "First Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter first name" : null,
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: mnameController,
                    decoration: const InputDecoration(
                      labelText: "Middle Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: lnameController,
                    decoration: const InputDecoration(
                      labelText: "Last Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter last name" : null,
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: mobileController,
                    decoration: const InputDecoration(
                      labelText: "Mobile No.",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        value!.isEmpty ? "Enter mobile number" : null,
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value!.isEmpty ? "Enter email" : null,
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? "Enter password" : null,
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 243, 95, 95),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: registerUser,
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.black54),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Color.fromARGB(255, 243, 95, 95),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
