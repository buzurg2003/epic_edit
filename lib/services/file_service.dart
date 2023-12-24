import 'dart:io';
import 'package:epic_edit/utils/snackbar_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FileService {
  final TextEditingController textController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();

  bool fieldsNotEmpty = false;

  File? _selectedFile;
  String _selectedDirectory = '';
  
  void saveContent(context) async {
    final title = textController.text;
    final textContent = 
        'Title:\n\n$title';
    
    try {
      if (_selectedFile != null) {
        await _selectedFile!.writeAsString(textContent);
      } else {
        final todayDate = getTodayDate(); 
        String metadataDirPath = _selectedDirectory;

        if (metadataDirPath.isEmpty) {
          final directory = await FilePicker.platform.getDirectoryPath();
          _selectedDirectory = metadataDirPath = directory!;
        }

        final filePath = '$metadataDirPath/$todayDate - $title - Metadata.txt';
        final newFile = File(filePath);
        await newFile.writeAsString(textContent);
      }
      SnackBarUtils.showSnackbar(context, Icons.check_circle, 'File saved successfully');
    } catch (e) {
      SnackBarUtils.showSnackbar(
        context, 
        Icons.error, 
        'File not saved',
      );
    }
  }

  void loadFile(context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        _selectedFile = file;

        final fileContent = await file.readAsString();

        final lines = fileContent.split('\n\n');
        textController.text = lines[1];
        SnackBarUtils.showSnackbar(
          context, 
          Icons.upload_file, 
          'File uploaded',
        );
      } else {
        SnackBarUtils.showSnackbar(
          context, 
          Icons.error_rounded, 
          'No file selected',
        );
      }
    } catch (e) {
      SnackBarUtils.showSnackbar(
        context, 
        Icons.error_rounded, 
        'No file selected'
      );
    }
  }

  void newFile(context) {
    _selectedFile = null;
    textController.clear();
    descriptionController.clear();
    tagsController.clear();

    SnackBarUtils.showSnackbar(
      context, 
      Icons.file_upload, 
      'New file created',
    );
  }

  void newDirectory(context) async {
  try { 
    String? directory = await FilePicker.platform.getDirectoryPath();
    if (directory != null) {
      _selectedDirectory = directory;
      _selectedFile = null;
    } else {
      SnackBarUtils.showSnackbar(
        context, 
        Icons.error_rounded, 
        'No folder selected'
      );
    }
  } catch (e) {
    SnackBarUtils.showSnackbar(
      context, 
      Icons.error_rounded, 
      'Error selecting folder: $e'
    );
  } 
}


  static String getTodayDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    final formatterDate = formatter.format(now);
    return formatterDate;
  }
}
