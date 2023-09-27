// ignore: implementation_imports, depend_on_referenced_packages
import 'package:async/src/result/result.dart';
// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:auth/src/domain/auth_service_contract.dart';
import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/domain/token.dart';
import 'package:auth/src/infra/api/auth_api_contract.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth implements IAuthService {
  final IAuthApi _authApi;
  final GoogleSignIn _googleSignIn;
  late GoogleSignInAccount _currentUser;

  GoogleAuth(this._authApi, [GoogleSignIn? googleSignIn])
      : _googleSignIn =
            googleSignIn ?? GoogleSignIn(scopes: ['email', 'profile']);

  @override
  Future<Result<Token>> signIn() async {
    await _handleGoogleSignIn();
    // ignore: unnecessary_null_comparison
    if (_currentUser == null) {
      return Result.error('Failed to signin with Google');
    }
    var displayName = _currentUser.displayName;
    Credential credential = Credential(
      type: AuthType.google,
      email: _currentUser.email,
      name: displayName!,
      password: '',
    );
    var result = await _authApi.signIn(credential);
    if (result.isError) return result.asError!;
    return Result.value(Token(result.asValue!.value));
  }

  @override
  Future<Result<bool>> signOut(Token token) async {
    var res = await _authApi.signOut(token);
    if (res.asValue!.value) _googleSignIn.disconnect();
    return res;
  }

  _handleGoogleSignIn() async {
    try {
      _currentUser = (await _googleSignIn.signIn())!;
    } catch (error) {
      return;
    }
  }
}
