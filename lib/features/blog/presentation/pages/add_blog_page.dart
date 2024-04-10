import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DottedBorder(
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
                child: const Center(
                  child: Icon(Icons.add_a_photo),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
