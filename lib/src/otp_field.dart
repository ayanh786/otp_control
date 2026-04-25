import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpField extends StatefulWidget {
  final int length;
  final double fieldWidth;
  final bool obscureText;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;

  const OtpField({
    super.key,
    this.length = 6,
    this.fieldWidth = 50,
    this.obscureText = false,
    this.onCompleted,
    this.onChanged,
  }) : assert(length >= 4 && length <= 6,
            "OTP length should be between 4 and 6");

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();

    _controllers =
        List.generate(widget.length, (_) => TextEditingController());

    _focusNodes =
        List.generate(widget.length, (_) => FocusNode());
  }

  void _handleChange(int index, String value) {
    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      }
    } else {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }

    final otp = _controllers.map((e) => e.text).join();

    widget.onChanged?.call(otp);

    if (otp.length == widget.length) {
      widget.onCompleted?.call(otp);
    }
  }

  InputDecoration _buildDecoration(ThemeData theme) {
    return InputDecoration(
      counterText: "",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: theme.colorScheme.primary,
          width: 2,
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: SizedBox(
            width: widget.fieldWidth,
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: _buildDecoration(theme),

              obscureText: widget.obscureText,
              obscuringCharacter: '•',

              onChanged: (value) {
                if (value.isNotEmpty) {
                  _controllers[index].text = value;
                  _controllers[index].selection =
                      const TextSelection.collapsed(offset: 1);
                }

                _handleChange(index, value);
              },
            ),
          ),
        );
      }),
    );
  }
}
