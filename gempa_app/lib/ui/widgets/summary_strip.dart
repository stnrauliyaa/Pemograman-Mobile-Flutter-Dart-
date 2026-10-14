import 'package:flutter/material.dart';

import 'magnitude_style.dart';

/// Ringkasan: jumlah gempa dan magnitudo terbesar.
class SummaryStrip extends StatelessWidget {
  const SummaryStrip({
    super.key,
    required this.total,
    required this.strongest,
  });

  final int total;
  final double strongest;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _Stat(
            icon: Icons.stacked_bar_chart_rounded,
            label: 'Jumlah gempa',
            value: total.toString(),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _Stat(
            icon: Icons.bolt_rounded,
            label: 'Terkuat',
            value: 'M ${strongest.toStringAsFixed(1)}',
            color: magnitudeColor(strongest),
          ),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w800)),
                Text(label,
                    style: textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
