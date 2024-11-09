import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'journal_view_model.dart';

@RoutePage()
class JournalView extends StatelessWidget {
  const JournalView({super.key});

  Future<void> _pickDate(BuildContext context, JournalViewModel model) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: model.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      model.setDate(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JournalViewModel(),
      builder: (context, child) {
        final model = context.watch<JournalViewModel>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Journal'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Journal Input Section
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: model.entryController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "How was your day? What are you feeling?",
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () => _pickDate(context, model),
                              icon: const Icon(Icons.calendar_today),
                              label: Text(
                                '${model.selectedDate.day}/${model.selectedDate.month}/${model.selectedDate.year}',
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  model.addEntry(model.entryController.text),
                              child: const Text('Add Entry'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: model.entries.isEmpty
                      ? const Center(
                          child: Text('No entries yet. Start journaling!'))
                      : ListView.builder(
                          itemCount: model.entries.length,
                          itemBuilder: (context, index) {
                            final entry = model.entries[index];
                            return Card(
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text(entry.content),
                                subtitle: Text(
                                  '${entry.date.day}/${entry.date.month}/${entry.date.year}',
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => model.deleteEntry(index),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
