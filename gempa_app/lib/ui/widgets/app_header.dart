import 'package:flutter/material.dart';

/// Header halaman: judul, tombol ganti tema, dan tombol muat ulang.
class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
    required this.onRefresh,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 12, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gempa Terkini',
                  style: textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 2),
                Text(
                  'Indonesia  •  Sumber BMKG',
                  style: textTheme.bodySmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          IconButton.filledTonal(
            tooltip: isDark ? 'Mode terang' : 'Mode gelap',
            onPressed: onToggleTheme,
            icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
          ),
          const SizedBox(width: 4),
          IconButton.filledTonal(
            tooltip: 'Muat ulang',
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
    );
  }
}
