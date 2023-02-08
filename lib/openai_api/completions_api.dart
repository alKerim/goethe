import 'dart:io';

import 'package:ai_poetry/openai_api/api_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:ai_poetry/openai_api/moderations_request.dart';
import 'package:ai_poetry/openai_api/moderations_response.dart';

import 'completions_request.dart';
import 'completions_response.dart';
import 'package:http/http.dart';

class CompletionsAPI {
  /// The completions endpoint
  static final Uri completionsEndpoint =
      Uri.parse('https://api.openai.com/v1/completions');

  static final Uri moderationsEndpoint =
      Uri.parse('https://api.openai.com/v1/moderations');

  /// The headers for the completions endpoint, which are the same for all requests
  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': "Bearer $openAIKey",
  };

  /// Gets a "poem" from the OpenAI completions endpoint
  static Future<CompletionsResponse> getNewPoem(String prompt) async {
    debugPrint('Getting a new poem');

    CompletionsRequest request = CompletionsRequest(
      model: 'text-davinci-003',
      prompt: prompt,
      maxTokens: 75,
      temperature: 0.8,
      topP: 1,
    );

    debugPrint(
        'Sending OpenAI API request with prompt, "{completionsPrompts[promptIndex]}", and temperature, temp.');
    Response response = await post(completionsEndpoint,
        headers: headers, body: request.toJson());
    debugPrint('Received OpenAI API response: ${response.body}');
    // Check to see if there was an error
    if (response.statusCode != 200) {
      // TODO handle errors
      debugPrint(
          'Failed to get a forecast with status code, ${response.statusCode}');
    }
    CompletionsResponse completionsResponse =
        CompletionsResponse.fromResponse(response);
    return completionsResponse;
  }

  /// Gets a "valuation" from the OpenAI moderation endpoint, to see if content is sensitive
  static Future<ModerationsResponse> getModerationClassification(
      String prompt) async {
    debugPrint('Classify sensitiveness of text');

    ModerationsRequest request = ModerationsRequest(input: prompt);

    debugPrint(
        'Sending OpenAI API request with prompt, "{completionsPrompts[promptIndex]}", and temperature, temp.');
    Response response = await post(moderationsEndpoint,
        headers: headers, body: request.toJson());
    debugPrint('Received OpenAI API moderation response: ${response.body}');
    // Check to see if there was an error
    if (response.statusCode != 200) {
      // TODO handle errors
      debugPrint(
          'Failed to get a forecast with status code, ${response.statusCode}');
    }
    ModerationsResponse moderationsResponse =
        ModerationsResponse.fromResponse(response);
    return moderationsResponse;
  }
}
