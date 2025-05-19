import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dog_image.dart';

class DogRepository {

  static const _apiKey =
      'live_X8lkTVWj22BXfDaEudNnpod3jfglHJZQX3Vvn5JMp1DyiZ2Rv45jdyVWk2TstQWO';

  static const _baseUrl = 'https://api.thedogapi.com/v1/images/search';

  Future<List<DogImage>> fetchDogImages({int limit = 15}) async {
    final uri = Uri.parse('$_baseUrl?limit=$limit');
    final response = await http.get(uri, headers: {'x-api-key': _apiKey});

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((item) => DogImage.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Falha ao carregar imagens (${response.statusCode})');
    }
  }
}
