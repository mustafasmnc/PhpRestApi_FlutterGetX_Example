class Post {
  List<Data>? data;

  Post({this.data});

  Post.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? body;
  String? author;
  String? categoryId;
  String? categoryName;

  Data(
      {this.id,
      this.title,
      this.body,
      this.author,
      this.categoryId,
      this.categoryName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    author = json['author'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['author'] = this.author;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    return data;
  }
}