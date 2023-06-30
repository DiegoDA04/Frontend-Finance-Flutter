import 'package:finance_flutter/offers/ui/offers/offersView.dart';
import 'package:finance_flutter/security/data/services/auth_service.dart';
import 'package:finance_flutter/security/ui/register/register_view.dart';
import 'package:flutter/material.dart';

import '../../../utils/validator.dart';
import '../../data/models/user.dart';
import '../../data/models/user.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthService authService = AuthService();

  bool _hidePassword = true;
  @override
  void initState() {
    super.initState();
  }

  Future<void> loginUsers() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign in...'),
        ),
      );

      User res = await authService.loginUser(
          emailController.text, passwordController.text);

      if (context.mounted) ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (res.id > 0) {
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => OffersView(),
              ),
              (route) => false);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email or password is incorrect'),
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
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 12.0,
                    ),
                    const Text(
                      "Inicia Sesión",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 28.0,
                        color: Color(0xFF0C1E38),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "Llena los campos con tu correo electronico y contraseña",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) =>
                          Validator.validateEmail(value ?? ""),
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
                        onPressed: loginUsers,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F4897),
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Todavia no tiene una cuenta?",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF8D8D8D),
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegisterView()));
                          },
                          child: const Text(
                            "Registrate aquí",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2F4897),
                              fontSize: 16.0,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
