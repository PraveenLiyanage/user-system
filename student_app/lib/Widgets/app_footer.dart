import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      color: Colors.blueGrey.shade900,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '© 2025 Student Portal | All rights reserved',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _footerLink("Privacy Policy"),
              const SizedBox(width: 20),
              _footerLink("Terms of Service"),
              const SizedBox(width: 20),
              _footerLink("Support"),
            ]),
          ],
        ),
      ),
    );
  }
}

Widget _footerLink(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Text(
      title,
      style: const TextStyle(
        color: Colors.white70,
        decoration: TextDecoration.underline,
        fontSize: 14,
      ),
    ),
    )
  );
}