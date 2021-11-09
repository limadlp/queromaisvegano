import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:queromaisvegano/helpers/firebase_errors.dart';
import 'package:queromaisvegano/models/user.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Usuario? user;

  bool _loading = false;
  bool get loading => _loading;

  bool get isLoggedIn => user != null;

  Future<void> signIn(
      {required Usuario user,
      required Function onFail,
      required Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      await _loadCurrentUser(firebaseUser: result.user);

      //await Future.delayed(Duration(seconds: 4));

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  void facebookLogin() {}

  Future<void> signUp(
      {required Usuario user,
      required Function onFail,
      required Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);
      //this.user = result.user!;
      user.id = result.user!.uid;
      this.user = user;

      await user.saveData();
      user.saveToken();

      onSuccess();
    } on FirebaseException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User? firebaseUser}) async {
    final User? currentUser = firebaseUser ?? auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('user').doc(currentUser.uid).get();
      user = Usuario.fromDocument(docUser);

      user!.saveToken();

      final docAdmin = await firestore.collection('admins').doc(user!.id).get();
      if (docAdmin.exists) {
        user!.admin = true;
      }
      notifyListeners();
    }
  }

  bool get adminEnabled => user != null && user!.admin!;
}
