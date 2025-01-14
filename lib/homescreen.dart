import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest API Call'),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
        final user = users[index];
        final name = user['name']['first'];
        final email = user['email'];
        final imageUrl = user['picture']['thumbnail'];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(imageUrl),
          ),
          title: Text(name.toString()),
          subtitle: Text(
            email,
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        child: const Icon(Icons.download),
      ),
    );
  }

  void fetchUsers() async {
    print('fetchUser called');
    const url = 'https://randomuser.me/api/?results=99';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'] ?? [];
    });
    print('fetchUsers completed');
  }
}
