class Country{
  final String name;
  final String code;
  final String flag;
  final String capital;
  final List<String> states;
  final int population;
  final String continent;
  final String religion;
  final String motto;
  final String officialLanguage;
  final double area;
  final bool independence;
  final String currency;
  final String timeZone;
  final String dateFormat;
  final String drivingSide;
  final String dialingCode;

  Country({
    required this.name,
    required this.code,
    required this.flag,
    required this.capital,
    required this.states,
    required this.population,
    required this.continent,
    required this.religion,
    required this.motto,
    required this.officialLanguage,
    required this.area,
    required this.independence,
    required this.currency,
    required this.timeZone,
    required this.dateFormat,
    required this.drivingSide,
    required this.dialingCode,

    });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] != null && json['name']['common'] != null ? json['name']['common'] : 'Unknown',
      code: json['cca2'] ?? 'N/A',
      flag: json['flags'] != null && json['flags']['png'] != null ? json['flags']['png'] : '',
      capital: (json.containsKey('capital') && json['capital'] is List && json['capital'].isNotEmpty)
          ? json['capital'][0]
          : 'N/A', // Handle missing or empty capital field
      states: (json.containsKey('subdivisions') && json['subdivisions'] is List)
          ? List<String>.from(json['subdivisions'].map((state) => state.toString()))
          : [],
      population: json['population'] ?? 0,
      continent: (json['continents'] as List?)?.first ?? 'Unknown',
      religion: json['religion'] ?? 'Unknown',
      motto: json['motto'] ?? 'Unknown',
      officialLanguage: json['languages'] != null
          ? (json['languages'] as Map).values.first
          : 'Unknown',
      area: json['area']?.toDouble() ?? 0.0,
      independence: json['independent'] ?? false,
      currency: json['currencies'] != null
          ? (json['currencies'] as Map).values.first['name'] ?? 'Unknown'
          : 'Unknown',
      timeZone: (json['timezones'] as List?)?.first ?? 'Unknown',
      dateFormat: json['date_format'] ?? 'Unknown',
      drivingSide: json['car']?['side'] ?? 'Unknown',
      dialingCode: json['idd']?['root'] != null && json['idd']?['suffixes'] != null
          ? '${json['idd']['root']}${json['idd']['suffixes'][0]}'
          : 'Unknown',// Handle missing or null subdivisions
    );
}
}