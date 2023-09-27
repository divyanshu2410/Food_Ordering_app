import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/infra/api/auth_api.dart'; // Make sure this import is correct
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  MockClient client;
  AuthApi sut;

  setUp(() {
  });
  
    client = MockClient();
    sut = AuthApi('http://baseUrl', client);

  group('signin', () {
    var credential = Credential(
      type: AuthType.email,
      email: 'email@email',
      password: 'pass',
      name: '',
    );

    test('should return error when status code is not 200', () async {
      // Arrange
      when(client.post(Uri.parse('http://baseUrl'), 
              body: anyNamed('body')))
          .thenAnswer((_) async =>
              http.Response(jsonEncode({'error': 'not found'}), 404));
      // Act
      var result = await sut.signIn(credential);
      // Assert
      expect(result, isA<ErrorResult>());
    });

    test('should return error when status code is 200 but malformed json', () async {
      // Arrange
      when(client.post(Uri.parse('http://baseUrl'), 
              body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('{}', 200));
      // Act
      var result = await sut.signIn(credential);
      // Assert
      expect(result, isA<ErrorResult>());
    });

    test('should return token string when successful', () async {
      // Arrange
      var tokenStr = 'Abbggs..';
      when(client.post(Uri.parse('http://baseUrl'), 
              body: anyNamed('body')))
          .thenAnswer((_) async =>
              http.Response(jsonEncode({'auth_token': tokenStr}), 200));
      // Act
      var result = await sut.signIn(credential);
      // Assert
      expect(result.asValue!.value, tokenStr);
    });
  });
}
