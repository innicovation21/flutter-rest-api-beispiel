import 'package:flutter/material.dart';
import 'package:rest_api_beispiel/screens/screen1.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Instanzierung vom Sizer-Package
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          // debug-banner ausblenden
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const Screen1(),
        );
      },
    );
  }
}
