import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'common_func.dart';

class CreateUser extends StatefulWidget {
  final String apiUrl;

  CreateUser({required this.apiUrl});

  @override
  CreateUserState createState() => CreateUserState();
}

class CreateUserState extends State<CreateUser> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();  
  final TextEditingController zipCodeController = TextEditingController();
  bool isLoading = false;

  // Create new user
  Future<void> submitUser() async {
    if (!_formKey.currentState!.validate()) {
      return; // Stop if form is invalid
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(widget.apiUrl),
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
        print("User Created Successfully!");
        Navigator.pop(context, true); // Return true to refresh user list
      } else {
        print("Failed to create user: ${response.statusCode}");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to create user")));
      }
    } catch (e) {
      print("Error creating user: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create User')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Attach form key
          child: Column(
            children: [
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator:
                    (value) => CommonFunc.validateFields(value, 'First Name'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator:
                    (value) => CommonFunc.validateFields(value, 'Last Name'),
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
                    onPressed: submitUser,
                    child: Text('Submit'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
