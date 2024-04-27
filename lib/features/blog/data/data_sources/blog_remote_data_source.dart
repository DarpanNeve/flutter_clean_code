import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/exception.dart';
import '../models/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  // Future<List<BlogModel>> getBlogs();
  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog});

  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl extends BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog}) async {
    try {
      await supabaseClient.storage
          .from('blog_images')
          .upload('image_${blog.id}.jpg', image);
      return supabaseClient.storage
          .from('blog_images')
          .getPublicUrl('image_${blog.id}.jpg');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs = await supabaseClient.from('blogs').select('*,profiles (*)');
      return blogs
          .map((e) => BlogModel.fromJson(e).copyWith(
                posterName: e['profiles']['name'],
              ))
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
