import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static Future<String> getAIResponse(String input) async {
    const url = 'https://api-inference.huggingface.co/models/facebook/blenderbot-400M-distill';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${dotenv.env['HF_API_KEY']}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'inputs': input}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data[0]['generated_text'] ?? "I couldn't understand that.";
    } else {
      return 'Error: Failed to get response.';
    }
  }
}
