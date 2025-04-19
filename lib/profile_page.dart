import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  void updateProfile() async {
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .update({
            'firstName': nameController.text.trim(),
            'role': roleController.text.trim(),
          });
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Profile updated!")));
    }
  }

  void fetchProfile() async {
    final doc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
    nameController.text = doc['firstName'] ?? '';
    roleController.text = doc['role'] ?? '';
  }

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "First Name"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: "Role"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: updateProfile, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
