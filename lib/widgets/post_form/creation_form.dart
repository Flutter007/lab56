import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/post_provider.dart';
import '../custom_text_form_field.dart';
import 'creation_form_controller.dart';

class CreationForm extends StatefulWidget {
  final String buttonText;
  final CreationFormController controller;
  final void Function() action;

  const CreationForm({
    super.key,
    required this.controller,
    required this.action,
    required this.buttonText,
  });

  @override
  State<CreationForm> createState() => _CreationFormState();
}

class _CreationFormState extends State<CreationForm> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PostProvider>();
    return provider.isCreating
        ? Center(child: CircularProgressIndicator())
        : Padding(
          padding: EdgeInsets.all(22),
          child: Form(
            key: widget.controller.formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  labelText: 'Enter Header',
                  controller: widget.controller.headerController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 3) {
                      return 'Please enter a header';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  labelText: 'Enter Post',
                  controller: widget.controller.bodyController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 3) {
                      return 'Please enter a post';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: widget.action,
                  child: Text(widget.buttonText),
                ),
              ],
            ),
          ),
        );
  }
}
