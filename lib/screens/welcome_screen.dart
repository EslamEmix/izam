import 'package:flutter/material.dart';
import 'package:izam_task/model/User.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("welcome : ${user.email}"), centerTitle: true),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Login Count"),
            const Divider(color: Colors.transparent),
            Text(user.loginCount.toString(),style: const TextStyle(fontSize: 36),)
          ],
        ),
      ),
    );
  }
}
