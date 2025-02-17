import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';
import 'create_user.dart';
import 'user_detail.dart';

void main() {
  runApp(MaterialApp(home: _UserApp()));
}

class _UserApp extends StatefulWidget {
  @override
  UserState createState() => UserState();
}

class UserState extends State<_UserApp> {
  late Future<List<User>> users;
  final String apiUrl = 'http://10.0.2.2:8088/api/users';

  @override
  void initState() {
    super.initState();
    users = fetchUsers();
  }

  /// Get all users
  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((user) => User.fromJson(user)).toList();
      } else {
        print('API Error: ${response.statusCode} - ${response.reasonPhrase}');
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  /// Refresh user list after create or update
  void refreshUserList() {
    setState(() {
      users = fetchUsers();
    });
  }

  /// Delete user
  Future<void> deleteUser(String userId) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$userId'));

      if (response.statusCode == 200) {
        print("User deleted successfully");
        setState(() {
          users = fetchUsers(); // Refresh list after deletion
        });
      } else {
        print("Failed to delete user: ${response.statusCode}");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to delete user")));
      }
    } catch (e) {
      print("Error deleting user: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users List')),
      body: FutureBuilder<List<User>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var user = snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text("${user.firstName[0]}${user.lastName[0]}"),
                  ),
                  title: Text("${user.firstName} ${user.lastName}"),
                  subtitle: Text(user.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Edit Button
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      UserDetails(user: user, apiUrl: apiUrl),
                            ),
                          );
                          if (result == true) {
                            refreshUserList();
                          }
                        },
                      ),
                      // Delete Button
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          // Confirm Before Deleting
                          bool confirmDelete = await showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: Text('Confirm Delete'),
                                  content: Text(
                                    'Are you sure you want to delete ${user.firstName} ${user.lastName}?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () => Navigator.pop(context, false),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed:
                                          () => Navigator.pop(context, true),
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                          );

                          if (confirmDelete == true) {
                            deleteUser(user.id.toString());
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateUser(apiUrl: apiUrl)),
          );
          if (result == true) {
            refreshUserList();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
