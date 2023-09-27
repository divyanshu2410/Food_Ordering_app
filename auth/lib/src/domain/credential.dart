// import 'package:flutter/foundation.dart';

class Credential {
  final AuthType type;
  late String name;
  final String email;
  late String password;

  Credential({
    required this.type,
    name,
    required this.email,
    password,
  });
}

enum AuthType { email, google }
