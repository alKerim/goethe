import 'dart:convert';

/// Represents the parameters used in the body of a request to the OpenAI completions endpoint.
class ModerationsRequest {
  final String input;

  ModerationsRequest({required this.input});

  String toJson() {
    Map<String, dynamic> jsonBody = {
      'input': input,
    };

    return json.encode(jsonBody);
  }
}
