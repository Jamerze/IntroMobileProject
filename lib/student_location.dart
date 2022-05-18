class StudentLocation {
  final int placeId;
  final String licence;
  final String osmType;
  final int osmId;
  final String lat;
  final String lon;
  final String displayName;
  final Address address;
  final List<String> boundingbox;

  StudentLocation(
      {required this.placeId,
      required this.licence,
      required this.osmType,
      required this.osmId,
      required this.lat,
      required this.lon,
      required this.displayName,
      required this.address,
      required this.boundingbox});

  factory StudentLocation.fromJson(Map<String, dynamic> json) {
    return StudentLocation(
        placeId: json['placeId'],
        licence: json['licence'],
        osmType: json['osmType'],
        osmId: json['osmId'],
        lat: json['lat'],
        lon: json['lon'],
        displayName: json['displayName'],
        address: json['address'],
        boundingbox: json['boundingbox']);
  }
}

class Address {
  final String building;
  final String houseNumber;
  final String road;
  final String neighbourhood;
  final String city;
  final String municipality;
  final String county;
  final String state;
  final String iSO31662Lvl6;
  final String region;
  final String iSO31662Lvl4;
  final String postcode;
  final String country;
  final String countryCode;

  Address(
      {required this.building,
      required this.houseNumber,
      required this.road,
      required this.neighbourhood,
      required this.city,
      required this.municipality,
      required this.county,
      required this.state,
      required this.iSO31662Lvl6,
      required this.region,
      required this.iSO31662Lvl4,
      required this.postcode,
      required this.country,
      required this.countryCode});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        building: json['building'],
        houseNumber: json['houseNumber'],
        road: json['road'],
        neighbourhood: json['neighbourhood'],
        city: json['city'],
        municipality: json['municipality'],
        county: json['county'],
        state: json['state'],
        iSO31662Lvl6: json['iSO31662Lvl6'],
        region: json['region'],
        iSO31662Lvl4: json['iSO31662Lvl4'],
        postcode: json['postcode'],
        country: json['country'],
        countryCode: json['countryCode']);
  }
}
