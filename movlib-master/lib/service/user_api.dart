import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movlib/model/app_user.dart';

class UserApi {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  static const _userCollection = 'users';

  static Future<User> signInWithGoogle() async {
    final FirebaseApp _initialization = await Firebase.initializeApp();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    return user;
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  static Future<AppUser> getUser(String id) async {
    AppUser appUser;

    final FirebaseApp _initialization = await Firebase.initializeApp();
    CollectionReference userCollectionRef =
        FirebaseFirestore.instance.collection(_userCollection);

    QuerySnapshot userQuery =
        await userCollectionRef.where('id', isEqualTo: id).limit(1).get();

    if (userQuery.size == 0)
      print('Failed to find user');
    else {
      print('userQuery: ${userQuery.docs.first.data()}');
      appUser = AppUser.fromJson(userQuery.docs.first.data());
      print('appUser: ${appUser.toJson()}');
    }

    return appUser;
  }

  static Future<bool> addUser(AppUser user) async {
    final FirebaseApp _initialization = await Firebase.initializeApp();
    CollectionReference userCollectionRef =
        FirebaseFirestore.instance.collection(_userCollection);

    await userCollectionRef.add(user.toJson()).then((value) {
      print('User added');
      return true;
    }).catchError((error) {
      print("Failed to add user: $error");
    });

    return false;
  }
}
