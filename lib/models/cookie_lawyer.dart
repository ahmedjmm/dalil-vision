class CookieLawyer {
  int? id;
  Title? title;
  final baseUri = 'https://dalilvision.com/api/get_nonce/?controller=AuthenticationCLA&method=generate_auth_cookie';

  CookieLawyer({required this.id, this.title});

  factory CookieLawyer.fromJson(Map<String, dynamic> json){

    return CookieLawyer(id: json['id'], title: Title.fromJson(json['title']));
  }

  @override
  String toString() {
    return '$id, $title';
  }
}

class Title {
  String? title;

  Title({required this.title});

  factory Title.fromJson(Map<String, dynamic> json){
    return Title(title: json['rendered']);
  }

  @override
  String toString() {
    return '$title';
  }
}