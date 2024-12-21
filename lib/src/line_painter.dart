

import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  LinePainter(
    this.cardOffset, {
    required this.cardWidth,
    required this.cardY,
    this.color = Colors.grey,
  });
  final double cardOffset;
  final double cardWidth;
  final Color color;
  final double cardY;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color.withOpacity(.3)
      ..strokeWidth = 2.0;

    // Container's x-center
    final double containerX = size.width / 2;

    // Top of the screen to the container
    final double containerY = size.height / (cardY - 0.1) + cardOffset;

    final double space = cardWidth / 3;

    // Draw left line
    canvas
      ..drawLine(
        Offset(containerX - space, 0),
        Offset(containerX - space, containerY),
        paint,
      )

      // Draw right line
      ..drawLine(
        Offset(containerX + space, 0),
        Offset(containerX + space, containerY),
        paint,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint on animation updates
  }
}
