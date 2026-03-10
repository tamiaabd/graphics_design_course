import 'package:flutter/material.dart';

/// Constrains [child] to [maxWidth] and centers it horizontally.
/// On mobile the screen is narrower than maxWidth so content fills naturally.
/// On web/tablet the content stays centered at the standard width.
class ResponsiveConstraint extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveConstraint({
    super.key,
    required this.child,
    this.maxWidth = 1080,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
