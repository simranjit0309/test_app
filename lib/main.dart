import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/provider.dart';
import 'package:test_app/screens/home_screen.dart';
import 'package:test_app/screens/login_screen.dart';
import 'package:test_app/screens/otp_screen.dart';

import 'screens/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<ProviderTest>(
        create: (_) => ProviderTest(),
      ),
    ], child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login_screen': (ctx) => LoginScreen(false,false),
        '/otp_screen': (ctx) =>   OTPScreen("",false),
        '/home_screen': (ctx) =>   HomeScreen(),
      },
      home: const MainScreen(),
    ));
  }
}