class LoggedInUser {
  final int id;
  final String name;
  final String email;

  LoggedInUser({
    required this.id,
    required this.name,
    required this.email,
  });

  factory LoggedInUser.fromJson(Map<String, dynamic> json) {
    return LoggedInUser(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'email' : email,
  };
}
