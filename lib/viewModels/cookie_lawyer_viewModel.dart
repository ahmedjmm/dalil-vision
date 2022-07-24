import 'dart:convert';

import 'package:flutter_projects/models/cookie_lawyer.dart';
import 'package:http/http.dart';

class CookieLawyerApiServices {

  final baseUri = 'https://dalilvision.com/api/get_nonce/?controller=AuthenticationCLA&method=generate_auth_cookie';
  List<CookieLawyer> list = [];

  Future<String> getNonce() async {
    final response = await get(Uri.parse(baseUri.toString()));
    if (response.statusCode == 200) {
      var dynamicResponse = await jsonDecode(response.body);
      String nonce = await dynamicResponse['nonce'];
      return nonce;
    }
    else {
      return 'not found';
    }
  }

  Future<String?> getCookie({required String nonce, required String email, required String password}) async {
    final uri = "https://dalilvision.com/api/authenticationcla/generate_auth_cookie/?nonce=$nonce&email=$email&password=$password";
    final response = await get(Uri.parse(uri));
    if(response.statusCode == 200){
      var dynamicResponse = await jsonDecode(response.body);
      String? cookie = await dynamicResponse['cookie'];
      if(cookie == null){
        return dynamicResponse['error'];
      }
      return cookie;
    }
    else {
      throw ('${response.statusCode}');
    }
  }

  Future<List<CookieLawyer>> getLawyers ({required String email, required String password}) async {
    var nonce = await getNonce();
    var cookie = await getCookie(
        nonce: nonce, email: email, password: password);
    if (cookie!.contains('error')) {
      throw(cookie);
    }
    final url = 'https://dalilvision.com/api/listingcla/get_listings/?cookie=$cookie';
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      var dynamicResponse = jsonDecode(response.body);
      if (dynamicResponse.toString().contains('error')) {
        var error = dynamicResponse['error'];
        throw (error);
      }
      else {
        list = List<CookieLawyer>.from(
            dynamicResponse.map((x) => CookieLawyer.fromJson(x)));
        return list;
      }
    }
    else {
      throw(response.body);
    }
  }
}