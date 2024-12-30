import 'dart:convert';
import 'dart:math';

import 'package:block_api/features/posts/models/post_data_ui_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PostsNetworkRepo {
  static Future<List<PostDataUiModel>> fetchPosts() async {
    var client = http.Client();
    List<PostDataUiModel> posts = [];
    try {
      final response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      List result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        PostDataUiModel post =
            PostDataUiModel.fromJson(result[i] as Map<String, dynamic>);
        posts.add(post);
       
      }
       return posts;
    } catch (e) {
      print(e);
      return [];
    }
  }


  static Future<bool> addEvent() async {
    var client = http.Client();
    try {
      final response = await client
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
            "title": "Sanjai",
            "body": "He is learning flutter",
            "userId": Random().nextInt(100).toString()
          });
      if(response.statusCode >= 201){
        return true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
    
  }
}
