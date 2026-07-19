import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'https://reqres.in/api';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
}
