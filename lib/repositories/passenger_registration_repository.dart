import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PassengerRegistrationRepository {
  static String mainUrl = "";

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<bool?> registerPassenger(String firstName, String lastName) async {
    var value = await storage.read(key: 'token');

    // final request = http.MultipartRequest('POST', Uri.parse(""));
    // request.headers['Authorization'] = 'Bearer $value';
    // request.fields['firstName'] = firstName;
    // request.fields['lastName'] = lastName;

    // final response = await request.send();
    // if (response.statusCode >= 200 && response.statusCode < 300) {
    //   return true;
    // } else {
    //   throw Exception('Registration failed');
    // }
    return true;
  }

  Future<bool?> uploadInfoWithImage(
      String firstName, String lastName, File? image) async {
    var value = await storage.read(key: 'token');

    final request = http.MultipartRequest('POST', Uri.parse(""));
    request.headers['Authorization'] = 'Bearer $value';
    request.fields['firstName'] = firstName;
    request.fields['lastName'] = lastName;

    if (image != null) {
      var stream = http.ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = http.MultipartFile(
        'image',
        stream,
        length,
        filename: image.path.split('/').last,
      );
      request.files.add(multipartFile);
    }

    final response = await request.send();
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      throw Exception('Registration failed');
    }
  }
}
