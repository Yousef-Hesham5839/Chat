import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// المستخدم الحالي
  User? get currentUser => _auth.currentUser;

  /// هل المستخدم الحالي هو المدير؟
  bool get isAdmin => currentUser?.email == 'admin@chat.com';

  /// الاستماع لحالة تسجيل الدخول
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// تسجيل حساب جديد
  Future<User?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) return null;

      await user.updateDisplayName(name);

      await _firestore.collection("users").doc(user.uid).set({
        "uid": user.uid,
        "name": name,
        "email": email,
        "photo": "",
        "about": "Hey there! I'm using Chat App.",
        "isOnline": true,
        "lastSeen": FieldValue.serverTimestamp(),
        "createdAt": FieldValue.serverTimestamp(),
      });

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(_firebaseError(e));
    }
  }

  /// تسجيل الدخول
  Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore
          .collection("users")
          .doc(credential.user!.uid)
          .update({
        "isOnline": true,
        "lastSeen": FieldValue.serverTimestamp(),
      });

      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(_firebaseError(e));
    }
  }

  /// تسجيل الخروج
  Future<void> logout() async {
    final user = _auth.currentUser;

    if (user != null) {
      await _firestore.collection("users").doc(user.uid).update({
        "isOnline": false,
        "lastSeen": FieldValue.serverTimestamp(),
      });
    }

    await _auth.signOut();
  }

  /// إعادة تعيين كلمة المرور
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  /// تحديث اسم المستخدم
  Future<void> updateName(String name) async {
    final user = _auth.currentUser;

    if (user == null) return;

    await user.updateDisplayName(name);

    await _firestore.collection("users").doc(user.uid).update({
      "name": name,
    });
  }

  /// حذف مستخدم من قاعدة البيانات (صلاحية مدير)
  Future<void> deleteUser(String uid) async {
    if (!isAdmin) throw Exception("Unauthorized");
    await _firestore.collection("users").doc(uid).delete();
  }

  /// إنشاء حساب مستخدم جديد بدون تسجيل خروج المدير
  Future<void> adminCreateUser({
    required String name,
    required String email,
    required String password,
  }) async {
    if (!isAdmin) throw Exception("Unauthorized");

    FirebaseApp? secondaryApp;
    try {
      secondaryApp = await Firebase.initializeApp(
        name: 'AdminCreateUserApp',
        options: Firebase.app().options,
      );

      final secondaryAuth = FirebaseAuth.instanceFor(app: secondaryApp);
      
      final credential = await secondaryAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null) {
        // Save to Firestore using the main app's firestore instance
        await _firestore.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "name": name,
          "email": email,
          "photo": "",
          "about": "Hey there! I'm using Chat App.",
          "isOnline": false,
          "lastSeen": FieldValue.serverTimestamp(),
          "createdAt": FieldValue.serverTimestamp(),
        });
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(_firebaseError(e));
    } finally {
      if (secondaryApp != null) {
        await secondaryApp.delete();
      }
    }
  }

  /// تحويل أكواد Firebase إلى رسائل مفهومة
  String _firebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case "user-not-found":
        return "No user found with this email.";

      case "wrong-password":
        return "Incorrect password.";

      case "invalid-email":
        return "Invalid email address.";

      case "email-already-in-use":
        return "Email is already in use.";

      case "weak-password":
        return "Password must be at least 6 characters.";

      case "network-request-failed":
        return "Check your internet connection.";

      default:
        return e.message ?? "Authentication error.";
    }
  }
}