import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController dobController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  void updateDOB() async {
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'dob': dobController.text.trim(),
    });
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("DOB updated!")));
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  void fetchDOB() async {
    final doc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
    dobController.text = doc['dob'] ?? '';
  }

  @override
  void initState() {
    super.initState();
    fetchDOB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: dobController,
              decoration: const InputDecoration(labelText: "Date of Birth"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateDOB,
              child: const Text("Update DOB"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: logout,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
