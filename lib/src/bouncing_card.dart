import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'line_painter.dart';

class BouncingCard extends StatefulWidget {
  const BouncingCard(
    this.text, {
    this.cardColor = Colors.black,
    this.pegColor = Colors.grey,
    this.exit = true,
    this.isPaused = false,
    this.fadeOUtDelay = const Duration(seconds: 5),
    this.cardY = 2.5,
    this.child,
    super.key,
  });
  final String text;
  final Color cardColor;
  final Color pegColor;
  final bool exit;
  final Duration fadeOUtDelay;
  final Widget? child;
  final double cardY;
  final bool isPaused;

  @override
  State<BouncingCard> createState() => _BouncingCardState();
}

class _BouncingCardState extends State<BouncingCard>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _fadeController;
  late Animation<double> _bounceAnimation;
  Timer? _exitTimer;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 1),
      vsync: this,
    );

    // Bounce animation curve
    _bounceAnimation = Tween<double>(begin: -500, end: 0).animate(
      CurvedAnimation(
        parent: _bounceController,
        curve: Curves.bounceOut,
        reverseCurve: Curves.easeInOut,
      ),
    );

    _bounceController.forward();

    // Fade-out animation controller
    _fadeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    if (widget.exit) {
      // Start fade-out after 6 seconds
      _initTimer();
    }
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _fadeController.dispose();
    _exitTimer?.cancel();
    super.dispose();
  }

  void _initTimer() {
    _exitTimer?.cancel();
    _exitTimer = Timer(widget.fadeOUtDelay, () {
      if (widget.isPaused) {
        _initTimer();
        return;
      }
      _bounceController.reverse();
      _fadeController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final borderRadius = BorderRadius.circular(16);
    final cardWidth = size.width * .9;
    final double cardX = cardWidth / 2 - 8;
    final double space = cardWidth / 3;
    return FadeTransition(
      opacity: Tween<double>(begin: 1, end: 0).animate(_fadeController),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Bouncing container
          AnimatedBuilder(
            animation: _bounceAnimation,
            builder: (context, child) {
              return Positioned(
                top: MediaQuery.of(context).size.height / widget.cardY +
                    _bounceAnimation.value,
                child: child!,
              );
            },
            child: SizedBox(
              width: cardWidth,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(.65),
                        ],
                        stops: const [
                          .0,
                          1,
                        ],
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: borderRadius,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 38,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: borderRadius,
                          color: widget.cardColor.withOpacity(0.24),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 200,
                            sigmaY: 200,
                            tileMode: TileMode.mirror,
                          ),
                          child: widget.child ??
                              Text(
                                widget.text,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 14,
                    left: cardX - space,
                    child: cardPeg(),
                  ),
                  Positioned(
                    top: 14,
                    right: cardX - space,
                    child: cardPeg(),
                  ),
                ],
              ),
            ),
          ),
          // Lines holding the container
          AnimatedBuilder(
            animation: _bounceAnimation,
            builder: (context, child) {
              return CustomPaint(
                size: size,
                painter: LinePainter(
                  _bounceAnimation.value,
                  cardWidth: cardWidth,
                  cardY: widget.cardY,
                  color: widget.pegColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget cardPeg() => Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: widget.pegColor.withOpacity(.3),
          ),
        ),
      );
}
