
import 'package:async/async.dart';
import 'package:auth/src/domain/auth_service.dart';
import 'package:auth/src/domain/credentials.dart';
import 'package:auth/src/domain/signup_service.dart';
import 'package:auth/src/domain/token.dart';
import 'package:auth/src/infra/api/auth_api.dart';
import 'package:flutter/cupertino.dart';

class EmailAuth implements IAuthService,  ISignUpService{

  final IAuthApi _api;
  Credential _credential;

  EmailAuth(this._api);

  void credential({
    @required String email,
    @required String password,
}) {
    _credential = Credential(
        type: AuthType.email,
        email: email,
        password: password
    );
  }

  @override
  Future<Result<Token>> signIn() async {
   assert(_credential != null);
   var result = await _api.signIn(_credential);
   if(result.isError) return result.asError;
   return Result.value(Token(result.asValue.value));
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Result<Token>> signUp(String name, String email, String password) async {
    Credential credential = Credential(
      type: AuthType.email,
      name: name,
      email: email,
      password: password,
    );
    var result = await _api.signUp(credential);
    if(result.isError) return result.asError;
    return Result.value(Token(result.asValue.value));
  }

}