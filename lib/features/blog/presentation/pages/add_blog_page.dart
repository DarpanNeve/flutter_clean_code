import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_code/core/util/pick_image.dart';
import 'package:flutter_clean_code/features/blog/presentation/widgets/blog_editor.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedFile = await pickImage();
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Blog'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done_rounded),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: selectImage,
                child: DottedBorder(
                  dashPattern: const [
                    8,
                    4,
                  ],
                  borderType: BorderType.RRect,
                  strokeCap: StrokeCap.round,
                  radius: const Radius.circular(20),
                  color: Theme.of(context).textTheme.bodyLarge!.color!,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    child: image == null
                        ? Center(
                            child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(Icons.add_a_photo),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: [
                  "Technology",
                  "Business",
                  "Programming",
                  "Entertainment",
                ]
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                if (selectedTopics.contains(e)) {
                                  selectedTopics.remove(e);
                                } else {
                                  selectedTopics.add(e);
                                }
                                setState(() {});
                              },
                              child: Chip(
                                color: selectedTopics.contains(e)
                                    ? MaterialStatePropertyAll(
                                        Theme.of(context).colorScheme.primary)
                                    : MaterialStatePropertyAll(
                                        Theme.of(context).colorScheme.surface),
                                label: Text(e),
                                side: selectedTopics.contains(e)
                                    ? null
                                    : const BorderSide(
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                          ),
                        )
                        .toList()),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              BlogEditor(hintText: "Blog Title", controller: titleController),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              BlogEditor(
                  hintText: "Blog Content", controller: contentController),
            ],
          ),
        ),
      ),
    );
  }
}
