import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'features/auth/screens/login_screen.dart';
import 'firebase_options.dart';
import 'core/widgets/app_theme.dart';

Future<void> main() async {
  // async => means executing asynchronous processes عمليات غير متزامنة
  // Future => (Future من النوع object هترجع main النتيجة مش هتصل فورًا، ولكن هتصل لاحقًا (الدالة
  WidgetsFlutterBinding.ensureInitialized();
  // (Android / IOS) platform قبل استخدام أي خدمات تحتاج إلى التواصل مع الـ Flutter هذا السطر يهيئ محرك
  await Firebase.initializeApp(
    // await => انتظر حتى تنتهي عملية التهيئة، ثم أكمل تنفيذ بقية الكود
    // firebase.initializeApp => firebase بالـ application تنشئ اتصال الـ
    options: DefaultFirebaseOptions.currentPlatform,
    // options: DefaultFirebaseOptions.currentPlatform => (Android / IOS) الحالية platform المناسبة للـ firebase تحدد إعدادات الـ
    // firebase_options الإعدادات دي بتيجي من ملف
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Chat App",
      theme: AppTheme.lightTheme(context),
      home: const LoginScreen(),
    );
  }
}
