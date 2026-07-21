import 'package:flutter/material.dart';
import 'package:login_ui/loginscrn.dart';
import 'package:provider/provider.dart';
// ---------------------------------------------------------------------
// COLORS
// Just plain constants — beginner friendly, no separate theme file.
// Professional palette: deep indigo + soft off-white. No neon.
// ---------------------------------------------------------------------
class AppColors {
  static const Color primary = Color(0xFF3B4CCA);
  static const Color background = Color(0xFFF7F8FB);
  static const Color textPrimary = Color(0xFF1E1E2D);
  static const Color textSecondary = Color(0xFF8A8DA0);
  static const Color border = Color(0xFFE3E5EC);
}

// ---------------------------------------------------------------------
// AUTH PROVIDER (this is the "Provider" state management part)
//
// A Provider works like this:
// 1. You make a class that extends ChangeNotifier.
// 2. Inside it, you keep variables (your "state") + methods to change them.
// 3. Whenever a method changes a variable, you call notifyListeners().
// 4. Any widget listening to this class automatically rebuilds itself.
//
// Here, AuthProvider holds:
//   - obscurePassword -> whether password text is hidden (••••) or visible
//   - isLoading       -> whether login/signup button should show a spinner
// Both login and signup screens will share this SAME provider instance,
// so there's one single source of truth instead of separate setState()
// calls in each screen.
// ---------------------------------------------------------------------
class AuthProvider extends ChangeNotifier {
  bool obscurePassword = true;
  bool isLoading = false;

  // Called when user taps the eye icon to show/hide password
  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners(); // tells UI: "hey, rebuild, something changed"
  }

  // Simulates a login/signup network call.
  // In a real app, this is where you'd call Firebase/Supabase/your API.
  Future<bool> submitForm() async {
    isLoading = true;
    notifyListeners(); // show the loading spinner

    await Future.delayed(const Duration(seconds: 2)); // fake network delay

    isLoading = false;
    notifyListeners(); // hide the loading spinner

    return true; // pretend it always succeeds for now
  }
}

void main() {
  runApp(
    // ChangeNotifierProvider makes AuthProvider available to every
    // widget below it in the tree (LoginScreen, SignupScreen, etc.)
    // without having to pass it manually through constructors.
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login UI App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Roboto',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}