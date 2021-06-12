
import 'package:async/async.dart';
import 'package:auth/src/domain/auth_service.dart';
import 'package:auth/src/domain/credentials.dart';
import 'package:auth/src/domain/token.dart';
import 'package:auth/src/infra/api/auth_api.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth implements IAuthService{

  final IAuthApi _api;
  GoogleSignIn _googleSignIn;
  GoogleSignInAccount _currentUser;

  GoogleAuth(this._api, [GoogleSignIn googleSignIn]) :
        this._googleSignIn = googleSignIn ??
            GoogleSignIn(scopes: ['email', 'profile'],);

  @override
  Future<Result<Token>> signIn() async {
   await _handleGoogleSignIn();
   if(_currentUser == null) return Result.error("Google sign in failed");
   Credential credential = Credential(
       type: AuthType.google,
       email: _currentUser.email,
       name: _currentUser.displayName
   );
   var result = await _api.signIn(credential);
   if(result.isError) return result.asError;
   return Result.value(Token(result.asValue.value));
  }

  @override
  Future<void> signOut() async {
   _googleSignIn.disconnect();
  }

  _handleGoogleSignIn() async {
    try{
      _currentUser =  await _googleSignIn.signIn();
    } catch(error) {
      return;
    }
  }

}