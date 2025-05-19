import 'package:flutter/material.dart';
import '../../models/post.dart';

class CreationFormController {
  final formKey = GlobalKey<FormState>();
  final headerController = TextEditingController();
  final bodyController = TextEditingController();

  Post getPost() {
    return Post(
      header: headerController.text,
      body: bodyController.text,
      createdAt: DateTime.now(),
    );
  }

  void setPost(Post post) {
    headerController.text = post.header;
    bodyController.text = post.body;
  }

  void dispose() {
    headerController.dispose();
    bodyController.dispose();
  }
}
