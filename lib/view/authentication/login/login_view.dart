import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youfirst/view/authentication/login/login_view_model.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      builder: (context, _) {
        final model = context.watch<LoginViewModel>();
        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Sign In',
                  style: TextStyle(
                      color: Color(0xff006C50),
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: model.emailController,
                        validator: model.emailValidation,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xff006C50)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: model.passwordController,
                        validator: model.passwordValidation,
                        obscureText: model.isPasswordVisible ? false : true,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xff006C50)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'Password',
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              model.togglePasswordVisibility();
                            },
                            icon: Icon(model.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 140, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor:
                              const Color(0xff006C50), // Button color
                        ),
                        onPressed: () {
                          model.login();
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(color: Color(0xff565A65)),
                          ),
                          TextButton(
                            onPressed: model.navigateToSignup,
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Color(0xff006C50)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
