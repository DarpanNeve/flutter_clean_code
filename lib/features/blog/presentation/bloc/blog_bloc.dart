import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_code/core/usecases/usecase.dart';

import '../../domain/entities/blog.dart';
import '../../domain/use_cases/get_all_blogs.dart';
import '../../domain/use_cases/upload_blog.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  })  : _getAllBlogs = getAllBlogs,
        _uploadBlog = uploadBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUploadEvent>(_onBlogUploadEvent);
    on<GetAllBlogsEvent>(_onGetAllBlogsEvent);
  }

  _onBlogUploadEvent(BlogUploadEvent event, Emitter<BlogState> emit) async {
    final result = await _uploadBlog(UploadBlogParams(
      image: event.image,
      title: event.title,
      content: event.content,
      posterId: event.posterId,
      topics: event.topics,
    ));

    result.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(BlogUploadSuccess()),
    );
  }

  _onGetAllBlogsEvent(GetAllBlogsEvent event, Emitter<BlogState> emit) async {
    final result = await _getAllBlogs(NoParams());

    result.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blogs) => emit(BlogsDisplaySuccess(blogs)),
    );
  }
}
