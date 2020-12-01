// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apiService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ApiService extends ApiService {
  _$ApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ApiService;

  @override
  Future<Response<dynamic>> login(Map<String, dynamic> body) {
    final $url = 'https://myevent.tbg.cm/api/login';
    final $headers = {'Accept': 'application/json'};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> register(Map<String, dynamic> body) {
    final $url = 'https://myevent.tbg.cm/api/register';
    final $headers = {'Accept': 'application/json'};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> registerFacebook(Map<String, dynamic> body) {
    final $url = 'https://myevent.tbg.cm/api/register/facebook';
    final $headers = {'Accept': 'application/json'};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> registerTwitter(Map<String, dynamic> body) {
    final $url = 'https://myevent.tbg.cm/api/register/twitter';
    final $headers = {'Accept': 'application/json'};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> user(String token) {
    final $url = 'https://myevent.tbg.cm/api/getuserbyid';
    final $headers = {'Authorization': token, 'Accept': 'application/json'};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateuser(
      String token, Map<String, dynamic> body) {
    final $url = 'https://myevent.tbg.cm/api/updateuser';
    final $headers = {'Authorization': token, 'Accept': 'application/json'};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getuser(String token, Map<String, dynamic> body) {
    final $url = 'https://myevent.tbg.cm/api/getuser';
    final $headers = {'Authorization': token, 'Accept': 'application/json'};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> forgetPassword(
      String token, Map<String, dynamic> body) {
    final $url = 'https://myevent.tbg.cm/api/getuser/password/email';
    final $headers = {'Authorization': token, 'Accept': 'application/json'};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> logout(String token) {
    final $url = 'https://myevent.tbg.cm/api/logout';
    final $headers = {'Authorization': token, 'Accept': 'application/json'};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
