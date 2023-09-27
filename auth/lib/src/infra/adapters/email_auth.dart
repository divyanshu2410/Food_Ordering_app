// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:auth/src/domain/auth_service_contract.dart';
import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/domain/token.dart';
import '../api/auth_api_contract.dart';

class EmailAuth implements IAuthService {
  final IAuthApi _api;
  Credential _credential;
  EmailAuth(this._api, this._credential);

  void credential({
    required String email,
    required String password,
  }) {
    _credential = Credential(
      type: AuthType.email,
      email: email,
      password: password,
      // name: '',
    );
  }

  @override
  Future<Result<Token>> signIn() async {
    // ignore: unnecessary_null_comparison
    assert(_credential != null);
    var result = await _api.signIn(_credential);
    if (result.isError) return result.asError!;
    return Result.value(Token(result.asValue!.value));
  }

  @override
  Future<Result<bool>> signOut(Token token) async {
    return await _api.signOut(token);
  }

  
}
