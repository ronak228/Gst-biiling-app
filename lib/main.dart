import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/billing_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

//GSt-billing-app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BillingProvider(),
      child: MaterialApp(
        title: 'GST Billing App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6B9DFF),
            primary: const Color(0xFF6B9DFF),
            secondary: const Color(0xFF81C784),
            tertiary: const Color(0xFFFFB74D),
            background: Colors.white,
            surface: Colors.white,
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            backgroundColor: const Color(0xFF6B9DFF).withOpacity(0.1),
            foregroundColor: const Color(0xFF6B9DFF),
            titleTextStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: Color(0xFF6B9DFF),
            ),
            iconTheme: const IconThemeData(
              color: Color(0xFF6B9DFF),
              size: 28,
            ),
          ),
          tabBarTheme: const TabBarTheme(
            labelColor: Color(0xFF6B9DFF),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF6B9DFF),
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          cardTheme: CardTheme(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Colors.grey[200]!,
                width: 1,
              ),
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            color: Colors.white,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Color(0xFF6B9DFF), width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            labelStyle: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
            ),
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 16,
            ),
            prefixIconColor: const Color(0xFF6B9DFF),
            suffixIconColor: const Color(0xFF6B9DFF),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: const Color(0xFF6B9DFF),
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF6B9DFF),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          iconTheme: const IconThemeData(
            color: Color(0xFF6B9DFF),
            size: 24,
          ),
          textTheme: TextTheme(
            titleLarge: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: Color(0xFF2C3E50),
            ),
            titleMedium: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3E50),
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
            ),
            bodyMedium: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
