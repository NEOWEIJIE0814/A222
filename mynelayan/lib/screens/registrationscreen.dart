import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();
  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Registration "),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              child: Image.asset(
                "assets/images/register.png",
                fit: BoxFit.cover,
              ),
            ),
            Card(
              elevation: 8,
              child: Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text("Registration Form"),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameEditingController,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 5)
                                      ? "name must be longer than 5"
                                      : null,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: TextStyle(),
                                  icon: Icon(Icons.person),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0))),
                            ),
                            TextFormField(
                              controller: _phoneEditingController,
                              keyboardType: TextInputType.phone,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 10)
                                      ? "phone must be longer or equal to 10"
                                      : null,
                              decoration: const InputDecoration(
                                  labelText: 'Phone',
                                  labelStyle: TextStyle(),
                                  icon: Icon(Icons.phone),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0))),
                            ),
                            TextFormField(
                              controller: _emailEditingController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) => val!.isEmpty ||
                                      !val.contains("@") ||
                                      !val.contains(".")
                                  ? "enter a valid email"
                                  : null,
                              decoration: const InputDecoration(
                                  labelText: 'E-mail',
                                  labelStyle: TextStyle(),
                                  icon: Icon(Icons.email),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0))),
                            ),
                            TextFormField(
                              controller: _passEditingController,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 5)
                                      ? "Password must be longer than 5"
                                      : null,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(),
                                  icon: Icon(Icons.lock),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0))),
                            ),
                            TextFormField(
                              controller: _pass2EditingController,
                              obscureText: true,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 5)
                                      ? "Password must be longer than 5"
                                      : null,
                              decoration: const InputDecoration(
                                  labelText: 'Re-enter password',
                                  labelStyle: TextStyle(),
                                  icon: Icon(Icons.lock),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0))),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: _isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked = value!;
                                      });
                                    }),
                                Flexible(
                                    child: GestureDetector(
                                  onTap: null,
                                  child: const Text(
                                    "Agree with Terms ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: ElevatedButton(
                                        onPressed: onRegisterDialog,
                                        child: const Text('Register')))
                              ],
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onRegisterDialog() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Check Your Form")));
      return;
    }
    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please Agree with terms and condition")));
      return;
    }
    String passa = _passEditingController.text;
    String passb = _pass2EditingController.text;
    if (passa != passb) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Check your password")));
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Register new account?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                registerUser();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void registerUser() {
    String name = _nameEditingController.text;
    String email = _emailEditingController.text;
    String phone = _phoneEditingController.text;
    String passa = _passEditingController.text;

    http.post(Uri.parse("http://10.144.152.24//mynelayan/php/register_user.php"),
        body: {
          "name": name,
          "email": email,
          "phone": phone,
          "password": passa,
        }).then((response) {
      print(response.body);
    });
  }
}
