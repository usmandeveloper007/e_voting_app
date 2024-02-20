import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_exceptions.dart';


class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

   Future<bool> login(String? email, String? password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      return true;
    }on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      rethrow;
    }
  }

  Future<bool> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = userCredential.user!;
      print('Signed in user: ${user.uid}');
      await user.sendEmailVerification();
      return true;
    }on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      rethrow;
    }
  }

   Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      return true;
    }on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      rethrow;
    }
  }


   Future<bool> changePassword({required String newPassword,required String currentPassword}) async {
    try {
      String currentUserEmail = _auth.currentUser!.email!;
      bool authenticated = await login(currentUserEmail,currentPassword);
      if (authenticated) {
        var user = _auth.currentUser;
        await user!.updatePassword(newPassword);
        print("PASSword Changed");
        return true;
      }else{
        return false;
      }
    } on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      throw e.toString();
    }
  }

  static logout() async => await _auth.signOut();

  Future reAuthenticatingUser({required String password}) async {
    try {
      final user = _auth.currentUser;
      final String currentUserEmail = _auth.currentUser!.email!;
      AuthCredential credentials = EmailAuthProvider.credential(email: currentUserEmail, password: password);
      await user!.reauthenticateWithCredential(credentials);
      return true;
    } on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      throw e.toString();
    }
  }


  Future deleteUser() async {
    try {
      final user = _auth.currentUser;
      await user!.delete();
      return true;
    } on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      throw e.toString();
    }
  }

  String getCurrentUserMail() {
    return _auth.currentUser?.email ?? "";
  }



}