import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:youfirst/core/app_locator.dart';
import 'package:youfirst/core/app_router.dart';
import 'package:youfirst/core/service/auth_service.dart';
import 'package:youfirst/core/viewmodel/base_view_model.dart';

class SignupViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  final _auth = locator<AuthService>();
  final _route = locator<AppRouter>();

  Future<void> signup() async {
    try {
      if (formKey.currentState!.validate()) {
        await _auth.signupWithEmail(
          emailController.text,
          passwordController.text,
          fullnameController.text,
          phoneController.text,
        );
      }
      navigateToQuestion();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _auth.logout();
    } catch (e) {
      log(e.toString());
    }
  }

  void navigateToLogin() {
    _route.push(const LoginRoute());
  }

  void navigateToQuestion() {
    _route.push(const QuestionRoute());
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  String? nameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    return null;
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

  String? phoneValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password is too short';
    }
    // if (!RegExp('^.*(?=.{8,})(?=.*[a-zA-Z])(?=.*d)(?=.*[!#\$%&? "]).*\$')
    //     .hasMatch(value)) {
    //   return 'Please enter a valid password';
    // }
    return null;
  }

  String? confirmpasswordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return ' Confirm your password';
    }
    if (value != passwordController.text) {
      return 'Confirm password doesn\'t match';
    }
    return null;
  }
}
