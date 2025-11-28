import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class PulsingBiometricButton extends StatefulWidget {
  final VoidCallback onTap;
  const PulsingBiometricButton({Key? key, required this.onTap})
    : super(key: key);

  @override
  State<PulsingBiometricButton> createState() => _PulsingBiometricButtonState();
}

class _PulsingBiometricButtonState extends State<PulsingBiometricButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: NeumorphicButton(
        onPressed: widget.onTap,
        style: NeumorphicStyle(
          shape: NeumorphicShape.convex, // Extruded look [cite: 26]
          boxShape: const NeumorphicBoxShape.circle(),
          depth: 8,
          intensity: 0.7,
          // Green glow upon success can be handled by changing this color dynamically
          color: Theme.of(context).colorScheme.surface,
        ),
        padding: const EdgeInsets.all(40.0),
        child: Icon(
          Icons.fingerprint,
          size: 60,
          color: Theme.of(context).colorScheme.primary, // Deep Blue [cite: 48]
        ),
      ),
    );
  }
}
