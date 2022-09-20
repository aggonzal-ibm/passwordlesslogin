import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AuthFirebaseUser {
  AuthFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

AuthFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AuthFirebaseUser> authFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<AuthFirebaseUser>((user) => currentUser = AuthFirebaseUser(user));
