import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example1/fetch_api_data_2/models/post_model.dart';
import 'package:getx_example1/fetch_api_data_2/providers/post_provider.dart';

class HomeController extends GetxController with StateMixin<List<dynamic>> {
  var postData = {};
  var addPostVar = {};
  List categoryList = [].obs;
  var choosenCatId = '0'.obs;
  var choosenCatName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getPosts();
    getCategories();
  }

  getCategories() {
    PostProvider().getCategories().then((response) {
      categoryList.assignAll(response);
    }, onError: (error) {
      print(error);
    });
  }

  getPosts() {
    PostProvider().getPosts().then((response) {
      change(response, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  createPost(BuildContext context) {
    PostProvider().createPost(addPostVar).then((response) {
      if (json.decode(response.body)["message"] == "Post Created") {
        getPosts();
        Navigator.of(context).pop();
        mySnackbar('Post Created');
      } else {
        //Navigator.of(context).pop();
        mySnackbar('Post Not Created');
      }
    });
  }

  updatePost(BuildContext context) {
    PostProvider().updatePost(postData).then((response) {
      if (json.decode(response.body)["message"] == 'Post Updated') {
        getPosts();
        Navigator.of(context).pop();
        mySnackbar('Post Updated');
      } else {
        //Navigator.of(context).pop();
        mySnackbar('Post Not Updated');
      }
    });
  }

  deletePost(BuildContext context) {
    PostProvider().deletePost(postData['id'].toString()).then((response) {
      if (json.decode(response.body)["message"] == "Post Deleted") {
        getPosts();
        Navigator.of(context).pop();
        mySnackbar('Post Deleted');
      } else {
        //Navigator.of(context).pop();
        mySnackbar('Post Not Deleted');
      }
    });
  }

  mySnackbar(String msg) {
    return Get.snackbar('', '',
        titleText: Center(
          child: Text(msg),
        ),
        snackPosition: SnackPosition.BOTTOM);
  }
}
