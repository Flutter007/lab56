import 'package:flutter/material.dart';
import 'package:lab56/app_routes.dart';
import 'package:provider/provider.dart';
import '../models/post.dart';
import '../provider/post_provider.dart';
import '../widgets/post_form/creation_form.dart';
import '../widgets/post_form/creation_form_controller.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final controller = CreationFormController();
  late String id;
  late Post post;
  late PostProvider postProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      id = ModalRoute.of(context)!.settings.arguments as String;
      postProvider = context.read<PostProvider>();
      await context.read<PostProvider>().getPost(id);
      setPost(postProvider.post);
    });
  }

  void setPost(Post? post) {
    if (post == null) return;
    controller.headerController.text = post.header;
    controller.bodyController.text = post.body;
  }

  void goBack() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  void sendPost() async {
    try {
      final post = Post(
        header: controller.headerController.text,
        body: controller.bodyController.text,
        createdAt: DateTime.now(),
        id: id,
      );
      await postProvider.createPost(post, 'PUT');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Post updated!')));
      }
      await postProvider.fetchPosts();
      goBack();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Something went wrong!')));
      }
    }
  }

  void updatePost() {
    if (controller.formKey.currentState!.validate()) {
      sendPost();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Post')),
      body: Column(
        children: [
          Expanded(
            child: CreationForm(
              controller: controller,
              action: updatePost,
              buttonText: 'Edit Post',
            ),
          ),
        ],
      ),
    );
  }
}
