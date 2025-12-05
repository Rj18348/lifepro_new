
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifepro_new/presentation/providers/ai_providers.dart';
import 'package:lifepro_new/presentation/providers/providers.dart';
import 'package:lifepro_new/domain/entities/daily_entry.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _noteController = TextEditingController();
  double _mood = 5.0;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submitEntry() async {
    final entry = DailyEntry(
      id: const Uuid().v4(),
      date: DateTime.now(),
      moodScore: _mood.round(),
      note: _noteController.text,
      aiGenerated: false,
    );

    await ref.read(wellbeingRepositoryProvider).saveEntry(entry);

    if (ref.read(aiEnabledProvider)) {
       // Logic to trigger AI would go here, updating the entry later
       // For now just show snackbar
       if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Entry Saved. AI generating guidance...')));
       }
       
       try {
         final guidance = await ref.read(aiServiceProvider).generateGuidance(entry);
          // In a real app we would update the entry in DB with guidance
         if (mounted) {
            showDialog(context: context, builder: (c) => AlertDialog(
              title: const Text('AI Guidance'),
              content: Text(guidance),
            ));
         }
       } catch (e) {
         if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('AI Error: $e')));
         }
       }
    } else {
       if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Entry Saved Locally.')));
       }
    }
  }

  @override
  Widget build(BuildContext context) {
    final aiEnabled = ref.watch(aiEnabledProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('LifeBalance AI'),
        actions: [
          Switch(
            value: aiEnabled,
            onChanged: (val) {
              ref.read(aiEnabledProvider.notifier).state = val;
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('How are you feeling today?', style: Theme.of(context).textTheme.headlineSmall),
            Slider(
              value: _mood,
              min: 1,
              max: 10,
              divisions: 9,
              label: _mood.round().toString(),
              onChanged: (val) => setState(() => _mood = val),
            ),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'Notes (optional)'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitEntry,
              child: const Text('Check In'),
            ),
            const Divider(),
            Expanded(
              child: _HistoryList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(wellbeingRepositoryProvider);
    
    // Simplification: In real app use a FutureProvider or StreamProvider for history
    return FutureBuilder<List<DailyEntry>>(
      future: repo.getHistory(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        if (snapshot.data!.isEmpty) return const Center(child: Text('No entries yet.'));
        
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final entry = snapshot.data![index];
            return ListTile(
              title: Text('Mood: ${entry.moodScore} - ${entry.date.toString().split(' ')[0]}'),
              subtitle: Text(entry.note ?? ''),
            );
          },
        );
      },
    );
  }
}
