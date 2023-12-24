import 'dart:io';

import 'package:epic_edit/services/file_service.dart';
import 'package:epic_edit/utils/app_styles.dart';
import 'package:epic_edit/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FileService fileService = FileService();

  @override
  void initState() {
    super.initState();
    addListeners(); 
  }

  @override
  void dispose() {
    removeListeners();
    super.dispose();
  }

  void addListeners() {
    List<TextEditingController> controllers = [
      fileService.textController,
    ];

    for (TextEditingController controller in controllers) {
      controller.addListener(_onFieldChanged);
    }
  }

  void removeListeners() {
    List<TextEditingController> controllers = [
      fileService.textController,
    ];

    for (TextEditingController controller in controllers) {
      controller.removeListener(_onFieldChanged);
    }
  }

  void _onFieldChanged() {
    setState(() {
      fileService.fieldsNotEmpty = fileService.textController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dark,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 25
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _mainButton(() => fileService.newFile(context), 'New File'),
                Row(
                  children: [
                    _actionButton(
                      () => fileService.loadFile(context), 
                      Icons.file_upload,
                    ),
                    _actionButton(() => fileService.newDirectory(context), Icons.folder),
                  ],
                ),
              ],
            ),
            CustomTextField(
              maxLines: 15, 
              hintText: 'Type some text...', 
              controller: fileService.textController,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _mainButton(fileService.fieldsNotEmpty ? () => fileService.saveContent(context) : null, 'Save'),
                _closeButton(() => exit(0), 'Close'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _mainButton(Function()? onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(),
      child: Text(text),
    );
  }

  ElevatedButton _closeButton(Function()? onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(),
      child: Text(text),
    );
  }

  IconButton _actionButton(Function()? onPressed, IconData icon) {
    return IconButton(
      onPressed: onPressed,
      splashColor: AppTheme.accent,
      splashRadius: 20, 
      icon: Icon(
        icon,
        color: AppTheme.medium,
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppTheme.accent,
      foregroundColor: AppTheme.dark,
      disabledBackgroundColor: AppTheme.disabledBackgroundColor,
      disabledForegroundColor: AppTheme.disabledForegroundColor,
    );
  }
}
