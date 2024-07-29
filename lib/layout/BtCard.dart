import 'package:flutter/material.dart';

class BtCard extends StatelessWidget {
  final Widget child;
  final double width;
  final EdgeInsets padding;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? shadow;

  const BtCard({
    Key? key,
    required this.child,
    this.width = double.infinity,
    this.padding = const EdgeInsets.all(16.0),
    this.shadow,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Colors.white,
        boxShadow: shadow ?? [],
      ),
      child: child,
    );
  }
}
