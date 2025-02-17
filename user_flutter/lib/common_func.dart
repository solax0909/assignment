class CommonFunc {
  /// Email Validation Regex (abc@abc.abc)
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  /// Validate Name (Required)
  /// Validate Name (Required)
  static String? validateFields(String? value, fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  /// Validate Email (Required & Format)
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    } else if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email (e.g., user@gmail.com)";
    }
    return null;
  }
}
