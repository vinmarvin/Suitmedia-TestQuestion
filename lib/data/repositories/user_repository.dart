import 'package:dio/dio.dart';
import '../../core/constants/api_config.dart';
import '../models/user_model.dart';

class UserRepository {
  final Dio _dio = Dio();

  Future<List<UserModel>> getUsers({int page = 1, int perPage = 10}) async {
    try {
      final response = await _dio.get(
        '${ApiConfig.baseUrl}/users',
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
        options: Options(
          headers: {
            'x-api-key': ApiConfig.apiKey,
          },
        ),
      );

      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((e) => UserModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }
}
