import 'dart:convert';

import 'package:http/http.dart';

class ModerationsResponse {
  final String? id;
  final String? model;
  final Map<String, dynamic> categories;
  final Map<String, dynamic> categoryScores;
  final bool? flagged;

  const ModerationsResponse({
    required this.id,
    required this.model,
    required this.categories,
    required this.categoryScores,
    required this.flagged,
  });

  /// Returns a [CompletionResponse] from the JSON obtained from the
  /// completions endpoint.
  factory ModerationsResponse.fromResponse(Response response) {
    // Get the response body in JSON format
    Map<String, dynamic> responseBody = json.decode(response.body);

    // Parse out information from the response
    Map<String, dynamic> results = responseBody['results'][0];

    // Parse out the choices
    Map<String, dynamic> categories = results['categories'];
    Map<String, dynamic> categoryScores = results['category_scores'];
    bool? flagged = results['flagged'];

    return ModerationsResponse(
        id: responseBody['id'],
        model: responseBody['model'],
        categories: categories,
        categoryScores: categoryScores,
        flagged: flagged);
  }
}
