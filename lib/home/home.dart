import 'package:flutter/material.dart';
import 'package:hunt_me/tab/chat/screens/chat_contact_screen.dart';
import 'package:hunt_me/tab/discover/discover_screen.dart';
import 'package:hunt_me/tab/job/screens/job_post_screen.dart';
import 'package:hunt_me/tab/notification/screens/notification_screen.dart';
import 'package:hunt_me/tab/setting/screens/setting_screen.dart';

import '../utills/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectIndex = 0;
  onItemClick(int index) {
    setState(() {
      selectIndex = index;
      tabController!.index = selectIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          DiscoverScreen(),
          ChatScreen(),
          JobPost(),
          NotificationScreen(),
          SettingScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ('Discover'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: ('Chat'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_rounded,
              size: 34,
            ),
            label: ('Post'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important),
            label: ('Notification'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: ('Profile'),
          ),
        ],
        unselectedItemColor: secondaryColor,
        selectedItemColor: buttonColor,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        // selectedLabelStyle: const TextStyle(fontSize: 16),
        currentIndex: selectIndex,
        onTap: onItemClick,
      ),
    );
  }
}
