class IHttp {
  Future get(String url,
      {String? token, Map<String, dynamic>? queryParams}) async {}

  post(String url, Map data, {String? token}) {}

  delete(String url) {}

  patch(String url, Map data) {}
}
