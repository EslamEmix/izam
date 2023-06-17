class InputValidator {
  final String _emailRegex = r"^[a-zA-Z]{3}\.[0-9]{4}@izam\.co$";
  final String _passwordRegex = r"^(?=.*\d)(?=.*[!$#^*]).{8,}$";
  static InputValidator? _instance;

  factory InputValidator() => _instance ??= InputValidator._();

  InputValidator._();

  String? isValidEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Please Enter your Email ";
    } else {
      email.replaceAll(' ', '');
      RegExp emailExp = RegExp(_emailRegex);
      bool isValidMail = emailExp.hasMatch(email);
      if (!isValidMail) {
        return "Please enter a valid mail";
      }
      return null;
    }
  }

  String? isValidPassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Please Enter your password ";
    } else if (password.length < 8) {
      return "Password must be greater than 8 characters";
    } else {
      RegExp passwordExp = RegExp(_passwordRegex);
      bool isValidPassword = passwordExp.hasMatch(password);
      if (!isValidPassword) {
        return "Password must contain at least one number and one of the following symbols (!\$#^*)";
      }
      return null;
    }
  }
}
