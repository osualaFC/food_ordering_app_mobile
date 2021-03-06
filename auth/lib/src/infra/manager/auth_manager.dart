
import 'package:auth/src/domain/credentials.dart';
import 'package:auth/src/infra/adapters/email_auth.dart';
import 'package:auth/src/infra/adapters/google_auth.dart';
import 'package:auth/src/infra/api/auth_api_service.dart';

import '../../../auth.dart';

class AuthManager {
  IAuthApi _api;
  AuthManager(IAuthApi api) {
    this._api = api;
  }

  IAuthService service(AuthType type) {
    var service;
    switch (type) {
      case AuthType.google:
        service = GoogleAuth(_api);
        break;
      case AuthType.email:
        service = EmailAuth(_api);
        break;
    }
    return service;
  }
}