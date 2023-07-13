import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medicineshop/helper/SharedPrefernce.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    }
    return null;
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided for that user';
      } else {
        throw 'An error occurred, please try again later';
      }
    } catch (e) {
      throw 'An error occurred, please try again later';
    }
  }

  Future SignOut() async {
    try {
      await LocalData.SaveUserLoggedInStatus(false);
      await LocalData.SaveUserEmail("");
      await LocalData.SaveUserphotoStatus("");
      await LocalData.Content(false);
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
