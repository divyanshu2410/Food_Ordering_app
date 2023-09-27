import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/infra/api/auth_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  http.Client client;
  AuthApi sut;
  String baseUrl = 'http://localhost:3000';
  setUp(() {
    client = http.Client();
    sut = AuthApi(baseUrl, client);

  group('signin', () {
    test('should return json web token when successful', () async {
      var credential = Credential(
          type: AuthType.email,
          name: 'Ans',
          email: 'newuser@mail.com',
          password: 'password');
          
      // client = http.Client();
      // sut = AuthApi(baseUrl, client);

      var result = await sut.signIn(credential);

      expect(result.asValue!.value, isNotEmpty);

    });
  });
});
}