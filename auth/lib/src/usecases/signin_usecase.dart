import 'package:async/async.dart';
import 'package:auth/src/domain/token.dart';
import 'package:auth/src/domain/auth_service.dart';

class SignInUseCase {
 final IAuthService _authService;

  SignInUseCase(this._authService);

  Future<Result<Token>> execute() async{
    return await _authService.signIn();
  }
}