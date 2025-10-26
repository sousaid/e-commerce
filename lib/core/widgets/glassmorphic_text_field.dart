




import 'dart:ui';
import 'package:flutter/material.dart';

enum FieldType { text, password, email, phone, number }

class GlassmorphicTextField extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;
  final IconData? icon;
  final FieldType fieldType;
  final String? Function(String)? customValidator;
  final bool required;
  final FocusNode? focusNode;
  final ValueChanged<String>? onTextChanged;
  final double glassOpacity;
  final double blurIntensity;
  final Color glassColor;
  final Color borderColor;
  final Color focusBorderColor;
  final Color placeholderColor;
  final Color inputTextColor;
  final Color iconColor;
  final EdgeInsets? contentPadding;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;

  const GlassmorphicTextField({
    super.key,
    required this.controller,
    required this.placeholder,
    this.icon,
    this.fieldType = FieldType.text,
    this.customValidator,
    this.required = false,
    this.focusNode,
    this.onTextChanged,
    this.glassOpacity = 0.9,
    this.blurIntensity = 10,
    this.glassColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.focusBorderColor = const Color(0xFF667eea),
    this.placeholderColor = Colors.grey,
    this.inputTextColor = Colors.black87,
    this.iconColor = Colors.grey,
    this.contentPadding,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
  });

  @override
  State<GlassmorphicTextField> createState() => GlassmorphicTextFieldState();
}

class GlassmorphicTextFieldState extends State<GlassmorphicTextField> {
  String? _validationError;
  bool _hidePassword = true;
  bool _isFocused = false;

  TextInputType _getKeyboardType() {
    switch (widget.fieldType) {
      case FieldType.email:
        return TextInputType.emailAddress;
      case FieldType.phone:
        return TextInputType.phone;
      case FieldType.number:
        return TextInputType.number;
      case FieldType.password:
        return TextInputType.visiblePassword;
      default:
        return TextInputType.text;
    }
  }

  // Public method to validate field
  String? validateField() {
    final text = widget.controller.text.trim();

    // Check if required
    if (widget.required && text.isEmpty) {
      setState(() {
        _validationError = '${widget.placeholder} is required';
      });
      return _validationError;
    }

    // Built-in validations
    if (text.isNotEmpty) {
      switch (widget.fieldType) {
        case FieldType.email:
          if (!_isValidEmail(text)) {
            setState(() {
              _validationError = 'Please enter a valid email address';
            });
            return _validationError;
          }
          break;
        case FieldType.phone:
          if (!_isValidPhone(text)) {
            setState(() {
              _validationError = 'Please enter a valid phone number';
            });
            return _validationError;
          }
          break;
        default:
          break;
      }
    }

    // Custom validator
    if (widget.customValidator != null) {
      final error = widget.customValidator!(text);
      setState(() {
        _validationError = error;
      });
      return error;
    }

    // Clear error if validation passes
    setState(() {
      _validationError = null;
    });
    return null;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^\+?[\d\s\-\(\)]{10,}$').hasMatch(phone);
  }

  // Public method to focus field
  void focus() {
    widget.focusNode?.requestFocus();
  }

  // Public method to clear error
  void clearError() {
    setState(() {
      _validationError = null;
    });
  }

  // Public method to get current value
  String getValue() {
    return widget.controller.text.trim();
  }

  void _handleTextChange(String value) {
    if (widget.onTextChanged != null) {
      widget.onTextChanged!(value);
    }

    // Auto-validate if there's already an error
    if (_validationError != null) {
      validateField();
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasError = _validationError != null && _validationError!.isNotEmpty;
    final bool isPasswordField = widget.fieldType == FieldType.password;
    final bool shouldObscure = isPasswordField && _hidePassword;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.blurIntensity,
              sigmaY: widget.blurIntensity,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: widget.glassColor.withOpacity(widget.glassOpacity),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: hasError
                      ? Colors.red.withOpacity(0.6)
                      : (_isFocused
                      ? widget.focusBorderColor
                      : widget.borderColor),
                  width: _isFocused || hasError ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Focus(
                onFocusChange: (focused) {
                  setState(() {
                    _isFocused = focused;
                  });
                },
                child: TextField(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  keyboardType: _getKeyboardType(),
                  obscureText: shouldObscure,
                  enabled: widget.enabled,
                  maxLines: widget.maxLines,
                  maxLength: widget.maxLength,
                  onChanged: _handleTextChange,
                  style: TextStyle(
                    color: widget.inputTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    hintStyle: TextStyle(
                      color: widget.placeholderColor.withOpacity(0.6),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: widget.icon != null
                        ? Icon(
                      widget.icon,
                      color: hasError
                          ? Colors.red.withOpacity(0.8)
                          : widget.iconColor,
                      size: 22,
                    )
                        : null,
                    suffixIcon: isPasswordField
                        ? IconButton(
                      icon: Icon(
                        _hidePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: widget.iconColor,
                        size: 22,
                      ),
                      onPressed: _togglePasswordVisibility,
                    )
                        : null,
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: widget.contentPadding ??
                        const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    counterText: '',
                  ),
                ),
              ),
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red.shade700,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _validationError!,
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}