
import 'package:con_nected/GridItems/JournalGridItem.dart';
import 'package:con_nected/GridItems/StoryGridItem.dart';
import 'package:con_nected/GridView/JournalGridView.dart';
import 'package:con_nected/GridView/StoryGridView.dart';
import 'package:con_nected/Journal/JournalDetail.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<JournalGridItem> likedJournals = JournalGridItem.likedJournals;

  List<JournalGridItem> myItems = JournalGridItem.journalList;
  List<StoryGridItem> likedStories = StoryGridItem.likedStories;
  List<JournalGridItem> myJournals = JournalGridItem.myJournals;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  void logout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF293936),

      body: Stack(
        children: <Widget>[
          Container(
            child:  Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(color: Colors.white, fontSize: 24.0),
                  ),
                  IconButton(
                    icon: Icon(Icons.exit_to_app, color: Colors.white),
                    onPressed: logout,
                  ),
                ],
              ),
            ),
          ),
          SlidingUpPanel(
            maxHeight: MediaQuery.of(context).size.height - 80,
            minHeight: MediaQuery.of(context).size.height * 0.5,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
            panel: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  isScrollable:true,
                  tabs: const [
                    Tab(text: 'My Journal',),
                    Tab(text: 'Liked Stories'),
                    Tab(text: 'Liked Journals'),
                    Tab(text: 'Watch Later'),
                    Tab(text: 'Watch Later'),
                  ],
                ),
                Expanded(
                 child: Container(
                      color: const Color(0xFFf8f5f7),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            JournalGridView(items: myJournals,onItemTap: (JournalGridItem item) {  // Assuming you've added an `onItemTap` callback to your JournalGridView widget.
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JournalDetail(journal: item,
                                    onLikedChanged: (updatedJournal) {
                                      setState(() {
                                        // Find the index of the journal you want to update
                                        int index = myItems.indexWhere((j) => j.id == updatedJournal.id); // Assuming you have an id for each journal.
                                        if (index != -1) {
                                          myItems[index] = updatedJournal;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              );
                            },),
                            StoryGridView(items: likedStories,
                                onLikeToggle: (String id) {
                                  setState(() {
                                    // Find the item by id
                                    final item = StoryGridItem.storyList.firstWhere((item) => item.id == id);
                                    // Toggle the liked property
                                    item.liked = !item.liked;
                                    if (item.liked == false) {
                                      likedStories.remove(item);
                                    }else{
                                      likedStories.add(item);
                                    }
                                  });
                                }),
                            JournalGridView(items: likedJournals,
                                onLikeToggle: (String id) {
                                  setState(() {
                                    // Find the item by id
                                    final item = JournalGridItem.journalList.firstWhere((item) => item.id == id);
                                    // Toggle the liked property
                                    item.liked = !item.liked;
                                    if (item.liked == false) {
                                      likedJournals.remove(item);
                                    }else{
                                      likedJournals.add(item);
                                    }
                                  });
                                }),
                            JournalGridView(items: myItems),
                            JournalGridView(items: myItems),
                          ],
                        ),
                      ),
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}


