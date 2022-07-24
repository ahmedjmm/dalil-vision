class Lawyer{
  final Title title;
  final Data data;
  double? distance;

  Lawyer({required this.title, required this.data, this.distance});

  factory Lawyer.fromJson(Map<String, dynamic> json) =>
      Lawyer(title: Title.fromJson(json['title']), data: Data.fromJson(json['listing_data']));
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

class Title {
  final String title;

  Title({required this.title});

  factory Title.fromJson(Map<String, dynamic> json) => Title(title: json['rendered']);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

class Data{
  Title? title;
  String? email;
  String? phone;
  String? website;
  Location? location;
  List<String>? logo;
  List<String>? cover;

  Data({this.title, this.email, this.phone, this.website, this.logo, this.cover, this.location});

  factory Data.fromJson(Map<String, dynamic> json) {
    var logo = json['_job_logo'];
    var cover = json['_job_cover'];

    return Data(title: json['title'], email: json['_job_email'], website: json['_job_website'],
        location: Location(latitude: json['geolocation_lat'], longitude: json['geolocation_long']),
        phone: json['_job_phone'], logo: List<String>.from(logo), cover: List<String>.from(cover)
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

class Location{
  String? latitude;
  String? longitude;

  Location({this.latitude, this.longitude});

  @override
  String toString() {
    return ('location parameters are: $longitude, $latitude');
  }
}