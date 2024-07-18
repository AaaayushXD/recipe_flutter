import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_project/services/http_service.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();

  // final _httpService = HttpService();
  factory AuthService() {
    return _singleton;
  }

  AuthService._internal();

  Future<bool> signUp(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("$credential from  auth service line 21");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> login(String email, String password) async {
    print("$email -> $password -> auth service reached.");
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print("$credential from login");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e);
      }
      return false;
    }
    // aaa@gmail.com -> AA123aa123
    // aayush@gmail.com -> Aayush1234
  }

  Future<bool> logout() async {
    try {
       await FirebaseAuth.instance.signOut();
       return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
  }
}
