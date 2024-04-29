import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_code/core/util/calculate_reading_time.dart';

import '../../domain/entities/blog.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;

  const BlogCard({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              blog.topics.isNotEmpty
                  ? Row(
                      children: blog.topics
                          .map(
                            (topic) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Chip(
                                padding: const EdgeInsets.all(5),
                                label: Text(topic),
                              ),
                            ),
                          )
                          .toList(),
                    )
                  : const SizedBox.shrink(),
              CachedNetworkImage(
                imageUrl: blog.imageUrl,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      blog.content,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("${calculateReadingTime(blog.content)} min")
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
