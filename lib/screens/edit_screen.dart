import 'package:flutter/material.dart';
import '../widgets/post_form/creation_form.dart';
import '../widgets/post_form/creation_form_controller.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final controller = CreationFormController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Post')),
      body: Column(
        children: [
          Expanded(
            child: CreationForm(
              controller: controller,
              action: () {},
              buttonText: 'Edit Post',
            ),
          ),
        ],
      ),
    );
  }
}
