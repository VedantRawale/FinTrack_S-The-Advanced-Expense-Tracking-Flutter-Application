import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> addNewProduct(String productName) async {
  final apiUrl = 'http://192.168.7.62:5000/add_product';

  // Prepare the data to send
  final Map<String, dynamic> data = {
    'product_name': productName,
  };

  // Convert data to JSON
  final jsonData = jsonEncode(data);
  print("Sending data: $jsonData");

  // Make the HTTP POST request
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonData,
    );

    if (response.statusCode == 200) {
      // Successful response
      print("Success!");
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String category = responseData['category'];
      print('Predicted category for $productName: $category');
      return category;
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
      print('Response: ${response.body}');
      return 'Others';
    }
  } catch (e) {
    print('Error: $e');
    return 'Others';
  }
  print("atlast");
}
