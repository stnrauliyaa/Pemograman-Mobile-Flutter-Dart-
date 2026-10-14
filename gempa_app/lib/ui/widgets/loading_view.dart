import 'package:flutter/material.dart';

/// Skeleton berdenyut yang meniru tata letak halaman sukses.
class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    Widget block(double height, {double radius = 20}) => Container(
          height: height,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(radius),
          ),
        );

    return FadeTransition(
      opacity: Tween<double>(begin: 0.4, end: 1).animate(_controller),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          block(250, radius: 28),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: block(76)),
              const SizedBox(width: 12),
              Expanded(child: block(76)),
            ],
          ),
          const SizedBox(height: 24),
          block(18, radius: 8),
          const SizedBox(height: 12),
          block(80),
          const SizedBox(height: 10),
          block(80),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Memuat data gempa...',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}
