import 'package:flutter/material.dart';
import 'package:login_ui/loginscrn.dart';
import 'package:provider/provider.dart';
class AppColors {
  static const Color primary = Color(0xFF3B4CCA);
  static const Color background = Color(0xFFF7F8FB);
  static const Color textPrimary = Color(0xFF1E1E2D);
  static const Color textSecondary = Color(0xFF8A8DA0);
  static const Color border = Color(0xFFE3E5EC);
}
class AuthProvider extends ChangeNotifier {
  bool obscurePassword = true;
  bool isLoading = false;
  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners(); 
  }
  Future<bool> submitForm() async {
    isLoading = true;
    notifyListeners(); 
    isLoading = false;
    notifyListeners(); 
    return true; 
  }
}
void main() {
  runApp(
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