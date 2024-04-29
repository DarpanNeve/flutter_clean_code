import 'dart:io';

import 'package:flutter_clean_code/core/error/exception.dart';
import 'package:flutter_clean_code/core/error/failure.dart';
import 'package:flutter_clean_code/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_clean_code/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:flutter_clean_code/features/blog/data/models/blog_model.dart';

import 'package:flutter_clean_code/features/blog/domain/entities/blog.dart';

import 'package:fpdart/src/either.dart';
import 'package:uuid/uuid.dart';

import '../../domain/repository/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl({required this.blogRemoteDataSource});

  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required File image,
      required String title,
      required String content,
      required String posterId,
      required List<String> topics}) async {
    try {
      BlogModel blogModel = BlogModel(
        title: title,
        content: content,
        posterId: posterId,
        topics: topics,
        id: const Uuid().v1(),
        imageUrl: '',
        updatedAt: DateTime.now(),
      );
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
          image: image, blog: blogModel);
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return Right(uploadedBlog);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();
      return Right(blogs);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
