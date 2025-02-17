// User model class
class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNo;
  final String? zipCode;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    required this.zipCode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNo: json['phoneNo'],
      zipCode: json['zipCode'],
    );
  }
}