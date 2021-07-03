import 'package:async/async.dart';
import 'package:auth/src/domain/auth_service.dart';
import 'package:auth/src/domain/token.dart';

class SignOutUseCase {
  final IAuthService _authService;

  SignOutUseCase(this._authService);

  Future<Result<bool>> execute(Token token) async {
    return await _authService.signOut(token);
  }
}