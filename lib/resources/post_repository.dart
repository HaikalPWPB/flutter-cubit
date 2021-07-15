import 'dart:convert';

import 'package:learn_cubit/model/post_model.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  Future<List<PostModel>> getPostsFromAPI() async {
    List<PostModel> list = [];
    var res = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var decodeBody = jsonDecode(res.body);
    for (var post in decodeBody) {
      PostModel p = PostModel.fromJson(post);
      list.add(p);
    }
    return list;
  }

  Future<PostModel> storePostToAPI(data) async {
    var res = await http.post(Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: _setHeaders(),
      body: jsonEncode(data)
    );

    PostModel post = jsonDecode(res.body);
    return post;
  } 

  _setHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
  }
}