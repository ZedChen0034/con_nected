import 'package:con_nected/GridItems/StoryGridItem.dart';
import 'package:flutter/material.dart';

class Story extends StatefulWidget {
  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {
  List<StoryGridItem> myItems = StoryGridItem.storyList;
  List<StoryGridItem> likedStories = StoryGridItem.likedStories;
  bool _isSearching = false;
  List<StoryGridItem> _filteredItems = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = myItems;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    setState(() {
      String searchText = _searchController.text.toLowerCase();
      if (searchText.isEmpty) {
        _filteredItems = myItems;
      } else {
        _filteredItems = myItems
            .where((item) =>
                item.tag.toLowerCase().contains(searchText) ||
                item.title.toLowerCase().contains(searchText) ||
                (item.content.toLowerCase().contains(searchText)))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        elevation: 2.0,

        backgroundColor: Colors.white,
        centerTitle: true,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style:  TextStyle(color: Colors.grey[700]),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              )
            : Text("Story Telling", style: TextStyle(color: Colors.grey[800])),
        leading: IconButton(
          onPressed: () {
            setState(() {
              if (_isSearching) {
                _isSearching = false;
                _searchController.clear();
              } else {
                _isSearching = true;
              }
            });
          },
          icon: _isSearching
              ? Icon(Icons.close, color: Colors.grey[600])
              : Icon(Icons.search_outlined, color: Colors.grey[600]),
        ),
      ),
      body: ListView.separated(
        itemCount: _filteredItems.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.0),
        itemBuilder: (context, index) {
          StoryGridItem item = _filteredItems[index];
          return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300]!,
                    blurRadius: 5,
                    offset: Offset(0, 3),  // Shadow position
                  ),
                ],
              ),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(item.imagePath,
                        fit: BoxFit.cover, height: 150, width: 150)),
                SizedBox(width: 10),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800])),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(item.tag, style: TextStyle(color: Colors.blue[700])),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(item.liked ? Icons.favorite : Icons.favorite_border),
                                color: item.liked ? Colors.red : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    item.liked = !item.liked;
                                    if (item.liked) {
                                      likedStories.add(item);
                                    } else {
                                      likedStories.remove(item);
                                    }
                                  });
                                },
                              ),
                              Text(item.like, style: TextStyle(color: Colors.grey[700]))
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
