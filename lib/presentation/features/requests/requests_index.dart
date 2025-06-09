// lib/presentation/features/requests/requests_page.dart


import 'package:app/core/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/request.dart';


final searchQueryProvider = StateProvider<String>((_) => '');
final selectedCategoryProvider = StateProvider<String>((_) => 'All');

class RequestsPage extends ConsumerWidget {
  static const categories = ['All', 'Cleaning', 'Nature', 'In-doors'];
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final asyncReqs = ref.watch(requestViewModelProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final loginState = ref.watch(loginViewModelProvider);

    return loginState.when(
        data: (user) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Requests'),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (v) =>
                        ref
                            .read(searchQueryProvider.notifier)
                            .state = v,
                        decoration: InputDecoration(
                          hintText: 'Search requests...',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.filter_alt),
                            onPressed: () {
                              /* eventual filtre avansate */
                            },
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 36,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (_, i) {
                            final cat = categories[i];
                            return ChoiceChip(
                              label: Text(cat),
                              selected: selectedCategory == cat,
                              onSelected: (_) =>
                              ref.read(selectedCategoryProvider.notifier).state = cat,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(backgroundImage: NetworkImage(
                      "${user!.avatar}&format.png",
                    )
                  ),
                )
              ]),

              body: asyncReqs.when(
              loading: () => const Center(child: CupertinoActivityIndicator()),
              error: (e, stack) => Center(child: Text('Eroare: $e, $stack')),
              data: (all) {

              final filtered = all.where((r) {
                final matchText = searchQuery.isEmpty ||
                    r.description.toLowerCase().contains(searchQuery.toLowerCase()) ||
                    r.requesterName.toLowerCase().contains(searchQuery.toLowerCase());
                final matchCat  = selectedCategory == 'All' ||
                    r.categories.map((cat) => cat.name).contains(selectedCategory);
                return matchText && matchCat;
              }).toList();

              if (filtered.isEmpty) {
                return const Center(child: Text('Nu sunt request-uri pentru moment.'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filtered.length,
                itemBuilder: (_, idx) {
                  final req = filtered[idx];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius
                          .circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(child: Text(req.requesterInitials)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(req.requesterName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)
                                      ),
                                      const SizedBox(height: 4),
                                      Text(req.timeAgo,
                                          style: const TextStyle(
                                              color: Colors.grey)
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4
                                  ),
                                  decoration: BoxDecoration(
                                    color: req.statusColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(req.status.toString(),
                                      style: TextStyle(color: req.statusColor)
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),
                            Text(req.description),

                            const SizedBox(height: 12),
                            // Tags / chips
                            Wrap(
                              spacing: 8,
                              children: req.categories.map((cat) {
                                return Chip(
                                  label: Text(cat.name),
                                  backgroundColor: cat.color
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 16),
                            // Buton principal + bookmark
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // handle request
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)
                                      ),
                                    ),
                                    child: const Text('Handle Request'),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: () {
                                    // bookmark action
                                  },
                                  icon: const Icon(Icons.bookmark_border),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
              },
            ),
          );
        },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('A apărut o eroare: $e')));
  }
}
