import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _googleSignInInitialized = false;

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;
  bool get isEmailVerified => _user?.emailVerified ?? false;

  AuthenticationProvider() {
    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // Initialize Google Sign In
  Future<void> _initGoogleSignIn() async {
    if (!_googleSignInInitialized) {
      await GoogleSignIn.instance.initialize();
      _googleSignInInitialized = true;
    }
  }

  // Set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Set error message
  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Register with email and password
  Future<User?> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      _setLoading(true);
      _setError(null);

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      _user = userCredential.user;

      // Send email verification
      await sendEmailVerification();

      _setLoading(false);
      notifyListeners();
      return _user;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _setError(_getFirebaseAuthErrorMessage(e.code));
      return null;
    } catch (e) {
      _setLoading(false);
      _setError('Registration failed. Please try again.');
      return null;
    }
  }

  // Login with email and password
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      _setLoading(true);
      _setError(null);

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = userCredential.user;
      _setLoading(false);
      notifyListeners();
      return _user;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _setError(_getFirebaseAuthErrorMessage(e.code));
      return null;
    } catch (e) {
      _setLoading(false);
      _setError('Login failed. Please try again.');
      return null;
    }
  }

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      _setLoading(true);
      _setError(null);

      // Initialize Google Sign In
      await _initGoogleSignIn();

      // Trigger the authentication flow
      final GoogleSignInAccount googleAccount = await GoogleSignIn.instance
          .authenticate();

      // Get ID token from authentication
      final String? idToken = googleAccount.authentication.idToken;

      if (idToken == null) {
        _setLoading(false);
        _setError('Failed to get authentication token');
        return null;
      }

      // Create a new credential
      final credential = GoogleAuthProvider.credential(idToken: idToken);

      // Sign in to Firebase with the Google credential
      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      _user = userCredential.user;
      _setLoading(false);
      notifyListeners();
      return _user;
    } on GoogleSignInException catch (e) {
      _setLoading(false);
      if (e.code == GoogleSignInExceptionCode.canceled) {
        // User cancelled, don't show error
        return null;
      }
      _setError('Google sign-in failed: ${e.description ?? 'Unknown error'}');
      return null;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _setError(_getFirebaseAuthErrorMessage(e.code));
      return null;
    } catch (e) {
      _setLoading(false);
      _setError('Google sign-in failed. Please try again.');
      return null;
    }
  }

  // Send email verification
  Future<bool> sendEmailVerification() async {
    try {
      _setError(null);

      if (_user != null && !_user!.emailVerified) {
        await _user!.sendEmailVerification();
        return true;
      }
      return false;
    } catch (e) {
      _setError('Failed to send verification email. Please try again.');
      return false;
    }
  }

  // Check if email is verified (reload user)
  Future<bool> checkEmailVerified() async {
    try {
      await _user?.reload();
      _user = _auth.currentUser;
      notifyListeners();
      return _user?.emailVerified ?? false;
    } catch (e) {
      return false;
    }
  }

  // Send password reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      _setLoading(true);
      _setError(null);

      await _auth.sendPasswordResetEmail(email: email);

      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _setError(_getFirebaseAuthErrorMessage(e.code));
      return false;
    } catch (e) {
      _setLoading(false);
      _setError('Failed to send reset email. Please try again.');
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      _setLoading(true);

      // Sign out from Google if initialized
      if (_googleSignInInitialized) {
        await GoogleSignIn.instance.signOut();
      }
      await _auth.signOut();

      _user = null;
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setLoading(false);
      _setError('Sign out failed. Please try again.');
    }
  }

  // Update display name
  Future<bool> updateDisplayName(String displayName) async {
    try {
      _setError(null);

      await _user?.updateDisplayName(displayName);
      await _user?.reload();
      _user = _auth.currentUser;

      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to update profile. Please try again.');
      return false;
    }
  }

  // Get Firebase Auth error messages
  String _getFirebaseAuthErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered. Please login instead.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'Password is too weak. Please use a stronger password.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-credential':
        return 'Invalid credentials. Please check your email and password.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
