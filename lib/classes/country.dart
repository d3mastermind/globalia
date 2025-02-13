class Country {
  final String name;
  final String? flagUrl;
  final String? coatOfArmUrl;
  final String emojiFlag;
  final int? population;
  final String capital;
  final String? continent;
  final String? countryCode;
  final List<String>? timeZone;

  Country({
    required this.name,
    required this.emojiFlag,
    required this.capital,
    this.flagUrl,
    this.coatOfArmUrl,
    this.timeZone,
    this.population,
    this.continent,
    this.countryCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] as String,
      emojiFlag: json['flag'] as String,
      capital: (json['capital'] as List<dynamic>?)?.first as String? ?? 'N/A',
      flagUrl: json['flags']?['png'] as String?,
      coatOfArmUrl: json['coatOfArms']?['png'] as String?,
      population: json['population'] as int?,
      continent: (json['continents'] as List<dynamic>?)?.first as String?,
      countryCode: json['cca2'] as String?,
      timeZone: (json['timezones'] as List<dynamic>?)?.cast<String>(),
    );
  }
}
