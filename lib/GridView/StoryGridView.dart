import 'package:con_nected/GridItems/StoryGridItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StoryGridView extends StatelessWidget {
  final List<StoryGridItem> items;
  final void Function(String index)? onLikeToggle;

  StoryGridView({super.key, required this.items, this.onLikeToggle});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(items[index].imagePath, fit: BoxFit.cover),
              const SizedBox(height: 6),
              Text(
                items[index].title,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(items[index].tag),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (onLikeToggle != null) {
                              onLikeToggle!(items[index].id);
                            }
                          },
                          child: Icon(
                            items[index].liked ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(items[index].like),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
