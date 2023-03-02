class ApiUrls {
  //** base url ->
  static const String baseUrl = 'https://disease.sh/v3/covid-19/';

  //*** covid status ->
  static const String worldsStatsApi = '${baseUrl}all';
  static const String countryStatsApi = '${baseUrl}countries';
}
