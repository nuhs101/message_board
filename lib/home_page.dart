import 'package:flutter/material.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> boards = [
    {"name": "Tech Talk", "image": "assets/tech.jpeg"},
    {"name": "Marvel Rivals", "image": "assets/marvelrivals.jpeg"},
    {"name": "Mental Health", "image": "assets/mental.png"},
    {"name": "Music Lovers", "image": "assets/music.jpeg"},
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Message Boards")),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(
                child: Text(
                  "Menu",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text("Message Boards"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: messageBoards.length,
        itemBuilder: (context, index) {
          final board = messageBoards[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.asset(board['image'], width: 40, height: 40),
              title: Text(board['name']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatPage(boardName: board['name']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
