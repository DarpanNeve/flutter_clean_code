import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_code/core/common/widgets/loader.dart';
import 'package:flutter_clean_code/core/util/show_snackbar.dart';
import 'package:flutter_clean_code/features/blog/presentation/widgets/blog_card.dart';

import '../bloc/blog_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<BlogBloc>().add(GetAllBlogsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-blog');
        },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogsDisplaySuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blogs = state.blogs[index];
                return BlogCard(blog: blogs);
              },
            );
          }
          return SizedBox(
            child: Center(
              child: Text(state.toString()),
            ),
          );
        },
      ),
    );
  }
}
