import 'package:flutter/material.dart';

import '../../../utils/validator.dart';
import '../../data/services/auth_service.dart';
import '../login/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _hidePassword = true;

  AuthService authService = AuthService();

  Future<void> registerUsers() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Loading data...'),
        ),
      );

      Map<String, dynamic> userData = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
      };

      dynamic res = await authService.registerUser(userData);

      if (context.mounted) ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (res == "success") {
        if (context.mounted) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginView()));
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Incorrect Registration'),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Container(
            padding: const EdgeInsets.only(
              right: 24.0,
              left: 24.0,
              bottom: 24.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Registrate",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28.0,
                      color: Color(0xFF0C1E38),
                    ),
                  ),
                  Text(
                    "Llena los campos necesarios para crear una cuenta y ver las ofertas inmobiliarias",
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    "Informacion Personal",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Color(0xFF0C1E38),
                    ),
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  TextFormField(
                    controller: firstNameController,
                    validator: (value) => Validator.validateEmail(value ?? ""),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "First name",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: Color(0xFF8D8D8D),
                      ),
                      prefixIcon: Icon(Icons.person),
                      filled: true,
                      fillColor: Color(0xFFF8FAFB),
                      prefixIconColor: Color(0xFF8D8D8D),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: lastNameController,
                    validator: (value) => Validator.validateEmail(value ?? ""),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Last name",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: Color(0xFF8D8D8D),
                      ),
                      prefixIcon: Icon(Icons.person),
                      filled: true,
                      fillColor: Color(0xFFF8FAFB),
                      prefixIconColor: Color(0xFF8D8D8D),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    "Informacion de Cuenta",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Color(0xFF0C1E38),
                    ),
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) => Validator.validateEmail(value ?? ""),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: Color(0xFF8D8D8D),
                      ),
                      prefixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: Color(0xFFF8FAFB),
                      prefixIconColor: Color(0xFF8D8D8D),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) =>
                        Validator.validatePassword(value ?? ""),
                    obscureText: _hidePassword,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: Color(0xFF8D8D8D),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF8FAFB),
                      prefixIcon: const Icon(Icons.lock),
                      prefixIconColor: const Color(0xFF8D8D8D),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                        child: Icon(
                          _hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      suffixIconColor: Color(0xFF8D8D8D),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    cursorColor: Colors.indigo,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: registerUsers,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2F4897),
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        "Crear cuenta",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
