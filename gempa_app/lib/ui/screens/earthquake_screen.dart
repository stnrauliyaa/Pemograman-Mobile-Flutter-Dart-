import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../models/earthquake.dart';
import '../../services/earthquake_service.dart';
import '../widgets/app_header.dart';
import '../widgets/error_view.dart';
import '../widgets/featured_quake_card.dart';
import '../widgets/loading_view.dart';
import '../widgets/quake_tile.dart';
import '../widgets/summary_strip.dart';

enum _Status { loading, success, error }

/// Halaman penuh yang mengatur state loading, sukses, dan error.
class EarthquakeScreen extends StatefulWidget {
  const EarthquakeScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<EarthquakeScreen> createState() => _EarthquakeScreenState();
}

class _EarthquakeScreenState extends State<EarthquakeScreen> {
  final EarthquakeService _service = EarthquakeService();

  _Status _status = _Status.loading;
  List<Earthquake> _quakes = const [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _status = _Status.loading);
    try {
      final data = await _service.fetchRecent();
      if (!mounted) return;
      setState(() {
        _quakes = data;
        _status = _Status.success;
      });
    } on EarthquakeException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.message;
        _status = _Status.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              isDark: widget.isDark,
              onToggleTheme: widget.onToggleTheme,
              onRefresh: _load,
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: KeyedSubtree(
                  key: ValueKey<_Status>(_status),
                  child: _buildBody(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_status) {
      case _Status.loading:
        return const LoadingView();
      case _Status.error:
        return ErrorView(message: _errorMessage, onRetry: _load);
      case _Status.success:
        final strongest =
            _quakes.fold<double>(0, (max, q) => math.max(max, q.magnitude));
        final others = _quakes.skip(1).toList();
        final textTheme = Theme.of(context).textTheme;
        return RefreshIndicator(
          onRefresh: _load,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              FeaturedQuakeCard(quake: _quakes.first),
              const SizedBox(height: 16),
              SummaryStrip(total: _quakes.length, strongest: strongest),
              const SizedBox(height: 26),
              Text(
                'Riwayat gempa M5.0+',
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              for (final quake in others) QuakeTile(quake: quake),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Sumber data: BMKG',
                  style: textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              ),
            ],
          ),
        );
    }
  }
}
