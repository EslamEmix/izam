class User {
  final String email;
  final String password;
  int loginCount;

  User({
    required this.email,
    required this.password,
    this.loginCount = 1,
  });

  factory User.fromMap(Map<String, dynamic> map) =>
      User(email: map["email"], password: map["password"], loginCount: map["loginCount"]);

  Map<String, dynamic> toMap() => {
        'email': email,
        'password': password,
        'loginCount': loginCount,
      };
}
