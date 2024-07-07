class ApiConstants {
  static const String apiBaseUrl =
      "https://instinctive-fish-utahceratops.glitch.me/api/v1/";
  static const String login = "${apiBaseUrl}Main/login";
  static const String createResturant = "${apiBaseUrl}Main/";
  static String getRestaurantDataBySubDomain(String subDomain) =>
      "${apiBaseUrl}Main/$subDomain";
  static String updateRestaurantData(String id) => "${apiBaseUrl}Main/$id";
}
