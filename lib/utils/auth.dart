import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  //SIGN UP METHOD
  Future signUp(
      {required String email,
      required String name,
      required String password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final currentUser = result.user!;

      users
          .doc(currentUser.uid)
          .set({"name": name, "uid": currentUser.uid, "email": email}).then(
              (documentReference) {
        // print("success");
        // return true;
        // Navigator.pushNamed(context, productRoute);
        // print(documentReference!.documentID);
        // clearForm();
      }).catchError((e) {
        return e;
      });

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    // print('signout');
  }
}
