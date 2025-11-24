import 'package:flutter/material.dart';

class InputCard extends StatefulWidget {
  final String label;
  final List<String> options;
  final Function(String) onChanged;

  const InputCard({
    required this.label,
    required this.options,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<InputCard> createState() => _InputCardState();
}

class _InputCardState extends State<InputCard> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.options[0]; // default to first option
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.label, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: selectedValue,
              isExpanded: true,
              items: widget.options.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
                widget.onChanged(newValue!);
              },
            ),
          ],
        ),
      ),
    );
  }
}