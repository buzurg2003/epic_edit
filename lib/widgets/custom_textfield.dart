import 'package:epic_edit/utils/app_styles.dart';
import 'package:epic_edit/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final int? maxLines;
  final String hintText;
  final TextEditingController controller;

  CustomTextField({
    super.key, 
    this.maxLines, 
    required this.hintText, 
    required this.controller
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void copyToClipboard(context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    SnackBarUtils.showSnackbar(
      context, 
      Icons.content_copy, 
      'Copied text',
    );
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    return Scrollbar(
      controller: _scrollController,
      child: TextField(
        scrollController: _scrollController,
        autofocus: true,
        focusNode: _focusNode,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        controller: widget.controller,
        maxLines: widget.maxLines,
        keyboardType: TextInputType.multiline,
        cursorColor: AppTheme.accent,
        style: AppTheme.inputStyle,
        decoration: InputDecoration(
          hintStyle: AppTheme.hintStyle,
          hintText: widget.hintText,
          suffixIcon: _copyButton(context),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.accent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.medium
            ),
          ),
          counterStyle: AppTheme.counter
        ),
      ),
    );
  }

  IconButton _copyButton(BuildContext context) {
    return IconButton(
      onPressed: widget.controller.text.isNotEmpty ? () => copyToClipboard(
          context, widget.controller.text
        ) : null, 
      color: AppTheme.accent,
      disabledColor: AppTheme.medium,
      splashColor: AppTheme.accent,
      splashRadius: 20,
      icon: Icon(Icons.content_copy_rounded),
    );
  }
}
