import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthAndStoreRemoteDataSource {
  Future authAndStore();
}

class AuthAndStoreRemoteDataSourceImpl implements AuthAndStoreRemoteDataSource {
  @override
  authAndStore() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    log(userCredential.user!.displayName ?? 'Error print log');
    if (userCredential.user != null) {
      log('sucess');
    }
  }
}
