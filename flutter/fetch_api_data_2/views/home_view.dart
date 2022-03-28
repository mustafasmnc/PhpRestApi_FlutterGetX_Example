import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example1/fetch_api_data_2/controllers/home_controller.dart';
import 'package:getx_example1/fetch_api_data_2/models/post_model.dart';

class HomeViewFetchApiData2 extends GetView<HomeController> {
  HomeController homecontroller = HomeController();
  String? title;
  String? body;
  @override
  HomeController dx = Get.put(HomeController());
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Posts'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.choosenCatId.value = '0';
          controller.choosenCatName.value = '';
          myDialog(context, false);
        },
      ),
      body: ListView(
        children: [
          Container(),
          myListView(),
        ],
      ),
    );
  }

  Widget myListView() {
    return Container(
      child: controller.obx(
        (data) => ListView.builder(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.all(8),
            itemCount: data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.choosenCatName.value =
                            data[index]['category_name'];
                        controller.choosenCatId.value =
                            data[index]['category_id'];
                        controller.postData.clear();
                        controller.postData["id"] = data[index]['id'];
                        controller.postData["title"] = data[index]['title'];
                        controller.postData["body"] = data[index]['body'];
                        controller.postData["author"] = data[index]['author'];
                        controller.postData["categoryId"] =
                            controller.choosenCatId.toString();
                        controller.postData["categoryName"] =
                            controller.choosenCatName.toString();

                        // controller.postData.add(Data(
                        //   id: data[index]['id'],
                        //   title: data[index]['title'],
                        //   body: data[index]['body'],
                        //   author: data[index]['author'],
                        //   categoryId: controller.choosenCatId.toString(),
                        //   categoryName: controller.choosenCatName.toString(),
                        // ));
                        myDialog(
                          context,
                          true,
                          posTitle: data[index]['title'],
                          postBody: data[index]['body'],
                          postCatId: controller.choosenCatId.toString(),
                        );
                      },
                      child: ListTile(
                        leading: Container(
                            alignment: Alignment.center,
                            width: 90,
                            child: Text(data[index]['category_name'])),
                        title: Text(data[index]['title']),
                        subtitle: Text(
                          data[index]['body'],
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
        onError: (error) => Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }

  myDialog(
    BuildContext context,
    bool isUpdate, {
    String? posTitle,
    String? postBody,
    String? postCatId,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Category'),
                        SizedBox(width: 20),
                        myDropDown()
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Title'),
                        TextField(
                          controller: TextEditingController()
                            ..text = isUpdate == true ? posTitle! : '',
                          onChanged: (value) {
                            isUpdate == true
                                ? controller.postData['title'] = value
                                : controller.addPostVar["title"] =
                                    value.toString();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Post'),
                        TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: TextEditingController()
                            ..text = isUpdate == true ? postBody! : '',
                          onChanged: (value) {
                            isUpdate == true
                                ? controller.postData['body'] = value
                                : controller.addPostVar["body"] =
                                    value.toString();
                          },
                        ),
                      ],
                    ),
                  ],
                )),
            actions: [
              Row(
                children: [
                  isUpdate == true ? deleteButton(context) : Container(),
                  Spacer(),
                  Row(
                    children: [
                      cancelButton(context),
                      addUpdateButton(context, isUpdate),
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }

  Widget myDropDown() {
    return Obx(() => DropdownButton(
        hint: controller.choosenCatName == ''
            ? Text('Choose a category')
            : Text('${controller.choosenCatName.toString()}'),
        items: controller.categoryList.map((e) {
          return DropdownMenuItem(
            value: e['id'].toString(),
            child: Text(e['name'].toString()),
          );
        }).toList(),
        onChanged: (newCatId) {
          controller.choosenCatId.value = newCatId.toString();
          controller.categoryList.forEach((element) {
            if (element['id'].toString() ==
                controller.choosenCatId.toString()) {
              controller.choosenCatName.value = element['name'];
            }
          });
        }));
  }

  // set up the buttons
  Widget cancelButton(BuildContext context) {
    return TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget deleteButton(BuildContext context) {
    return TextButton(
      child: Text(
        "Delete",
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        dx.deletePost(context);
      },
    );
  }

  Widget addUpdateButton(BuildContext context, bool isUpdate) {
    return TextButton(
      child: Text(isUpdate == true ? "Update" : "Add"),
      onPressed: () {
        if (isUpdate) {
          controller.postData['categoryId'] =
              controller.choosenCatId.toString();
          dx.updatePost(context);
        } else {
          controller.addPostVar["author"] = "smnc";
          controller.addPostVar["category_id"] =
              controller.choosenCatId.toString();
          dx.createPost(context);
        }
      },
    );
  }
}
