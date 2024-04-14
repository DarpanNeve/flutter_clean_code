import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/upload_blog.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;

  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUploadEvent>(_onBlogUploadEvent);
  }

  _onBlogUploadEvent(BlogUploadEvent event, Emitter<BlogState> emit) async {
    final result = await uploadBlog(UploadBlogParams(
      image: event.image,
      title: event.title,
      content: event.content,
      posterId: event.posterId,
      topics: event.topics,
    ));

    result.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(BlogSuccess()),
    );
  }
}
