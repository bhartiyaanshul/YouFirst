import 'package:youfirst/core/supabase.dart';

class AuthService {
  Future<void> signupWithEmail(
      String email, String password, String fullname, String phone) async {
    final res = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'user_metadata': {'name': fullname, 'phone': phone}
      },
    );
  }

  Future<void> loginWithEmail(
      {required String email, required String password}) async {
    final res = await supabase.auth
        .signInWithPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
