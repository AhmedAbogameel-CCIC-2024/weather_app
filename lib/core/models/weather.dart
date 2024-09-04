class Weather {
  final String status;
  final num temp;
  final num humidity;
  final String city;
  final String country;
  final num latitude;
  final num longitude;

  Weather({
    required this.status,
    required this.temp,
    required this.humidity,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      status: json['weather'][0]['main'],
      temp: num.parse(json['main']['temp'].toString()) - 273.15,
      humidity: num.parse(json['main']['humidity'].toString()),
      city: json['name'],
      country: json['sys']['country'],
      latitude: json['coord']['lat'],
      longitude: json['coord']['lon'],
    );
  }
}
