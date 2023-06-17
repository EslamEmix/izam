class InputValidator {
  final String _emailRegex = r"^[a-zA-Z]{3}\.[0-9]{4}@izam\.co$";
  final String _passwordRegex = r"^(?=.*\d)(?=.*[!$#^*]).{8,}$";
  static InputValidator? _instance;

  factory InputValidator() => _instance ??= InputValidator._();

  InputValidator._();

  bool isValidMail(String email) => RegExp(_emailRegex).hasMatch(email);

  bool isValidPassword(String password) =>
      RegExp(_passwordRegex).hasMatch(password);

  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return "Please Enter your Email ";
    } else {
      if (!isValidMail(email)) {
        return "Please enter a valid mail";
      }
      return null;
    }
  }

  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return "Please Enter your password ";
    } else if (password.length < 8) {
      return "Password must be greater than 8 characters";
    } else {
      if (!isValidPassword(password)) {
        return "Password must contain at least one number and one of the following symbols (!\$#^*)";
      }
      return null;
    }
  }
}
