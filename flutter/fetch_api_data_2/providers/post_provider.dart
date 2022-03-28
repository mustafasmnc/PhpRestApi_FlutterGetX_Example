import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_example1/fetch_api_data_2/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostProvider extends GetConnect {
  String mainLink = "localhost/php_rest_myblog/api";

  Future<List<dynamic>> getCategories() async {
    final response = await get("http://$mainLink/category/read.php");
    if (response.status.hasError) {
      return Future.error(response.statusCode.toString());
    } else {
      return response.body['data'];
    }
  }

  Future<List<dynamic>> getPosts() async {
    final response = await get("http://$mainLink/post/read.php");
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      return response.body['data'];
    }
  }

  Future createPost(var post) async {
    return http.post(Uri.parse("http://$mainLink/post/create.php"),
        body: jsonEncode(<String, String>{
          "title": post["title"],
          "body": post["body"],
          "author": post["author"],
          "category_id": post["category_id"]
        }));
  }

  Future updatePost(var post) {
    return http.put(Uri.parse("http://$mainLink/post/update.php"),
        body: jsonEncode(<String, String>{
          "id": post['id'].toString(),
          "title": post['title'].toString(),
          "body": post['body'].toString(),
          "author": post['author'].toString(),
          "category_id": post['categoryId'].toString()
        }));
    //   .then((value) {
    // print(json.decode(value.body)["message"]);
    //});
  }

  Future deletePost(String postId) {
    return http.delete(Uri.parse("http://$mainLink/post/delete.php"),
        body: jsonEncode(<String, String>{"id": postId}));
  }
}
