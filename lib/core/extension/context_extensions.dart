




import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

extension ContextExtensions on BuildContext {
  S get tr => S.of(this);  // ✅ Short and sweet!
}