import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart'; // Import user model
import 'common_func.dart';

class UserDetails extends StatefulWidget {
  final User user;
  final String apiUrl;

  UserDetails({required this.user, required this.apiUrl});

  @override
  UserDetailsState createState() => UserDetailsState();
}

class UserDetailsState extends State<UserDetails> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNoController;
  late TextEditingController zipCodeController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.user.firstName);
    lastNameController = TextEditingController(text: widget.user.lastName);
    emailController = TextEditingController(text: widget.user.email);
    phoneNoController = TextEditingController(text: widget.user.phoneNo);
    zipCodeController = TextEditingController(text: widget.user.zipCode);
  }

  /// Update User API Call (PUT)
  Future<void> updateUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.patch(
        Uri.parse('${widget.apiUrl}/${widget.user.id}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "firstName": firstNameController.text.trim(),
          "lastName": lastNameController.text.trim(),
          "email": emailController.text.trim(),
          "phoneNo": phoneNoController.text.trim(),
          "zipCode": zipCodeController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        print("User Updated Successfully!");
        Navigator.pop(context, true); // Return true to refresh list
      } else {
        print("Failed to update user: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update user")),
        );
      }
    } catch (e) {
      print("Error updating user: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    setState(() => isLoading = false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) => CommonFunc.validateFields(value, "First Name"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) => CommonFunc.validateFields(value, "Last Name"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: CommonFunc.validateEmail,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: phoneNoController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: zipCodeController,
                decoration: InputDecoration(labelText: 'Zip Code'),
              ),
              SizedBox(height: 10),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: updateUser,
                      child: Text('Update'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
