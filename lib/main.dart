import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izam_task/bloc/login/login_bloc.dart';
import 'package:izam_task/helper/app_colors.dart';
import 'package:izam_task/helper/app_theme.dart';
import 'package:izam_task/screens/login_screen.dart';

void main() {
  runApp(const IzamApp());
}

class IzamApp extends StatefulWidget {
  const IzamApp({super.key});

  @override
  State<IzamApp> createState() => _IzamAppState();
}

class _IzamAppState extends State<IzamApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.mainTheme,
      debugShowCheckedModeBanner: false,
      title: "Daftra",
      home: BlocProvider(
          create: (BuildContext context) => LoginBloc(),
          child: const Scaffold(body: LoginScreen())),
    );
  }
}
