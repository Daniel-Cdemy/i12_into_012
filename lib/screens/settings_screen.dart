import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/providers/app_state_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final asks = ref.watch(asksForDeletionConfirmationProvider);
    final notifier = ref.read(appStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDarkMode,
            onChanged: (_) => notifier.toggleDarkMode(),
          ),
          SwitchListTile(
            title: const Text('Ask for Deletion Confirmation'),
            value: asks,
            onChanged: (_) => notifier.toggleDeletionConfirmation(),
          ),
        ],
      ),
    );
  }
}
