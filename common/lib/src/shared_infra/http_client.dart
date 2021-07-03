import 'package:http/http.dart';
import 'http_client_service.dart';

class HttpClientImpl implements IHttpClient {
  final Client _client;

  HttpClientImpl(this._client);

  @override
  Future<HttpResult> get(url, {Map<String, String> headers}) async {
    final response = await _client.get(url, headers: headers);
    return HttpResult(response.body, _setStatus(response));
  }

  @override
  Future<HttpResult> post(url, String body,
      {Map<String, String> headers}) async {
    final response = await _client.post(url, body: body, headers: headers);
    return HttpResult(response.body, _setStatus(response));
  }

  _setStatus(Response response) {
    if (response.statusCode != 200) return Status.failure;
    return Status.success;
  }
}