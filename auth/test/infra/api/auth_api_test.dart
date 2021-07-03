import 'dart:convert';

import 'package:auth/src/domain/credentials.dart';
import 'package:auth/src/infra/api/auth_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:async/async.dart';

class MockClient extends Mock implements http.Client{}

void main() {
  MockClient client;
  AuthApi sut; //service under test
  setUp(() {
  client = MockClient();
  sut = AuthApi("http:baseUrl", client);
  });

  group("signin", (){
    var credential = Credential(
        type: AuthType.email,
        email: "e@gmail.com",
        password: "password");

    test("should return error when status code is not 200", () async {
      //arrange
      when(client.post(any, body: anyNamed("body")))
          .thenAnswer((_) async => http.Response("{}", 404));
      //act
      var result = await sut.signIn(credential);
      //assert
      expect(result, isA<ErrorResult>());
    });

    test("should return error when status code 200 but json token is null", () async {
      //arrange
      when(client.post(any, body: anyNamed("body")))
          .thenAnswer((_) async => http.Response("{}", 200));
      //act
      var result = await sut.signIn(credential);
      //assert
      expect(result, isA<ErrorResult>());
    });

    test("should return a token when status code 200 and json token is not null", () async {
      //arrange
      var token = "fnkjgnkjdnjd";
      when(client.post(any, body: anyNamed("body")))
          .thenAnswer((_) async => http.Response(jsonEncode({"auth_token": token}), 200));
      //act
      var result = await sut.signIn(credential);
      //assert
      expect(result.asValue.value, token);
    });
  });
}