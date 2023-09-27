import 'package:food_ordering_app/cache/local_store_contract.dart';

abstract class SecureClient implements IHttpClient {
  final IHttpClient client;
  final ILocalStore store;
  SecureClient(this.client, this.store);

  Future<HttpResult> get(String url, {required Map<String, String> headers}) async {
    final token = await store.fetch();
    final modifiedHeader = headers;
    modifiedHeader['Authorization'] = token.value;
    return await client.get(url, headers: modifiedHeader);
  }

  Future<HttpResult> post(String url, String body,
      {required Map<String, String> headers}) async {
    final token = await store.fetch();
    final modifiedHeader = headers;
    modifiedHeader['Authorization'] = token.value;
    return await client.post(url, body, headers: modifiedHeader);
  }
}

abstract class HttpResult {
   Future<HttpResult> get(String url, {Map<String, String> headers});
  Future<HttpResult> post(String url, String body,
      {Map<String, String> headers});
}

class IHttpClient {
    late final String data;
    // final Status status;

  // const HttpResult(this.data, this.status);
  
  get(String url, {required Map<String, String> headers}) {}
  
  post(String url, String body, {required Map<String, String> headers}) {}
}

enum Status { success, failure }
