import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:youfirst/core/app_locator.dart';
import 'package:youfirst/core/app_router.dart';
import 'package:youfirst/core/service/auth_service.dart';
import 'package:youfirst/core/viewmodel/base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  final _auth = locator<AuthService>();
  final _route = locator<AppRouter>();

  Future<void> login() async {
    try {
      if (formKey.currentState!.validate()) {
        await _auth.loginWithEmail(
            email: emailController.text, password: passwordController.text);
      }
    } catch (e) {
      log(e.toString());
    }
    return;
  }

  void navigateToSignup() {
    _route.push(const SigupRoute());
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(
            '^[a-zA-Z0-9]+(?:.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(?:.[a-zA-Z0-9]+)*\$')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password is too short';
    }
    return null;
  }
}
