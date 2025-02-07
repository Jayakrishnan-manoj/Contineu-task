import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  const CustomCupertinoTextField({
    super.key,
    this.hintText = "Enter text",
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.controller,
  });

  @override
  State<CustomCupertinoTextField> createState() =>
      _CustomCupertinoTextFieldState();
}

class _CustomCupertinoTextFieldState extends State<CustomCupertinoTextField> {
  late TextEditingController _controller;
  late bool _isObscured;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _isObscured = widget.isPassword;
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: _controller,
      focusNode: _focusNode,
      obscureText: _isObscured,
      keyboardType: widget.keyboardType,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      placeholder: widget.hintText,
      placeholderStyle: TextStyle(color: CupertinoColors.systemGrey),
      clearButtonMode: OverlayVisibilityMode.editing,
      suffix: widget.isPassword
          ? GestureDetector(
              onTap: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  _isObscured
                      ? CupertinoIcons.eye_slash_fill
                      : CupertinoIcons.eye_fill,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            )
          : null,
      prefix: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: widget.isPassword
            ? Icon(
                CupertinoIcons.lock,
                color: CupertinoColors.systemGrey,
              )
            : Icon(CupertinoIcons.person, color: CupertinoColors.systemGrey),
      ),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: CupertinoColors.systemGrey4),
      ),
      maxLines: 1,
      maxLength: 20,
      onChanged: (value) {
        setState(
            () {}); // Updates the UI when text changes (e.g., character count)
      },
    );
  }
}
