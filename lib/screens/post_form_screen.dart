import 'package:flutter/material.dart';
import 'package:lab56/models/post.dart';
import 'package:lab56/widgets/post_form/creation_form.dart';
import 'package:provider/provider.dart';

import '../provider/post_provider.dart';
import '../widgets/post_form/creation_form_controller.dart';

class PostFormScreen extends StatefulWidget {
  const PostFormScreen({super.key});

  @override
  State<PostFormScreen> createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  final controller = CreationFormController();
  late PostProvider postProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    postProvider = context.read<PostProvider>();
  }

  void sentPost() async {
    try {
      final post = Post(
        header: controller.headerController.text,
        body: controller.bodyController.text,
        createdAt: DateTime.now(),
      );
      await postProvider.createPost(post, 'POST');
      await Future.delayed(Duration(milliseconds: 70));
      clearInfo();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Post created!')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Something went wrong!')));
      }
    }
  }

  void createPost() {
    if (controller.formKey.currentState!.validate()) {
      sentPost();
    }
  }

  void clearInfo() {
    controller.headerController.clear();
    controller.bodyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Post')),
      body: Column(
        children: [
          Expanded(
            child: CreationForm(
              controller: controller,
              action: createPost,
              buttonText: 'Create Post',
            ),
          ),
        ],
      ),
    );
  }
}
