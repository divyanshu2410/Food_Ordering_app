import 'package:auth/auth.dart';
import 'package:auth/src/infra/adapters/google_auth.dart';

class AuthManager {
  late IAuthApi _api;
  AuthManager(IAuthApi api) {
    _api = api;
  }

  IAuthService get google => GoogleAuth(_api);

  IAuthService email({
    required String email,
    required String password,
  }) {
    
    final emailAuth = EmailAuth(_api, Credential(type: AuthType.email, email: email)); 
    emailAuth.credential(email: email, password: password);
    return emailAuth;
  }
}
 