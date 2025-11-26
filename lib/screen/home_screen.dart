import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/input_card.dart';
import '../models/entry.dart';
import '../providers/entry_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String transport = 'Car';
  String food = 'Meat';
  String energy = 'High';
  int? lastScore;

  // Simple eco tips list
  final List<String> ecoTips = [
    "🚴 Try biking instead of driving today!",
    "💡 Turn off lights when not in use.",
    "🥦 Eat more plant-based meals.",
    "♻️ Recycle and reuse whenever possible.",
    "🌳 Plant a tree or care for a plant."
  ];
  int tipIndex = 0;

  void _nextTip() {
    setState(() {
      tipIndex = (tipIndex + 1) % ecoTips.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EntryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('EcoTrack')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            Text(
              "Hello 👋, ready to track today?",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),

            // 🌗 Theme toggle without text
            Align(
              alignment: Alignment.centerRight,
              child: Switch(
                value: provider.isDarkMode,
                onChanged: (_) => provider.toggleTheme(),
              ),
            ),
            const SizedBox(height: 20),

            // Input cards with expanded options
            InputCard(
              label: 'Transport',
              options: ['Car', 'Bike', 'Bus', 'Train', 'Walking', 'Electric Car'],
              onChanged: (val) => setState(() => transport = val),
            ),
            InputCard(
              label: 'Food',
              options: ['Meat', 'Vegetarian', 'Vegan', 'Pescatarian', 'Flexitarian'],
              onChanged: (val) => setState(() => food = val),
            ),
            InputCard(
              label: 'Energy',
              options: ['Low', 'Medium', 'High', 'Solar', 'Wind', 'Mixed'],
              onChanged: (val) => setState(() => energy = val),
            ),
            const SizedBox(height: 24),

            // Log Entry button
            ElevatedButton(
              onPressed: () {
                final entry = CarbonEntry(
                  transport: transport,
                  food: food,
                  energy: energy,
                  timestamp: DateTime.now(),
                );

                provider.addEntry(entry);
                final score = provider.calculateCarbonScore(entry);

                setState(() {
                  lastScore = score;
                });
              },
              child: const Text('Log Entry'),
            ),
            const SizedBox(height: 20),

            // 🌿 Carbon score card with progress bar
            if (lastScore != null)
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        '🌿 Your Carbon Score',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: (lastScore! / 100).clamp(0.0, 1.0),
                        color: Theme.of(context).primaryColor,
                        backgroundColor: Colors.grey[300],
                        minHeight: 10,
                      ),
                      const SizedBox(height: 8),
                      Text('$lastScore / 100', style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 24),

            // 🌱 Eco tips card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      '💡 Eco Tip of the Day',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        ecoTips[tipIndex],
                        key: ValueKey(tipIndex),
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _nextTip,
                      child: const Text('Next Tip'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
