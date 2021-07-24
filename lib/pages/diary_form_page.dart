import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:catatan_harian/controller/diary_controller.dart';
import 'package:catatan_harian/models/diary_model.dart';
import 'package:catatan_harian/static_data.dart';

class DiaryFormPage extends StatelessWidget {
  final controller = Get.put(DiaryController());
  late DiaryModel diary;
  @override
  Widget build(BuildContext context) {
    diary = Get.arguments ?? DiaryModel(title: "No Title", content: "");
    controller.titleController.text = diary.title;
    controller.contentController.text = diary.content;
    // if (diary) {
    // } else {
    //   controller.titleController.text = "No Title";
    // }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StaticData.bgColor,
        title: TextFormField(
          controller: controller.titleController,
          decoration:
              InputDecoration(border: InputBorder.none, hintText: "Fill title"),
          style: TextStyle(color: Colors.white),
          autofocus: true,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              DiaryModel newdiary = DiaryModel(
                  title: controller.titleController.text,
                  content: controller.contentController.text);
              if (diary.uid != "") {
                newdiary.uid = diary.uid;
                controller.databaseUtil.updatediary(newdiary);
              } else {
                controller.databaseUtil.adddiary(newdiary);
              }
              Get.offAllNamed("/home");
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: TextFormField(
          controller: controller.contentController,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: "Fill content"),
          keyboardType: TextInputType.multiline,
          minLines: 99,
          maxLines: 99,
        ),
      ),
    );
  }
}
