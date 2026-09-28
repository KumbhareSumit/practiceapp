import 'package:flutter/material.dart';

class NavigationHubScreen extends StatelessWidget {
  const NavigationHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. defaultTabController automatically syncs the tabBar with tabbarview

    return DefaultTabController(
      length: 3, // we are creating exactly 3 tab
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Navigation Hub Lab'),
          backgroundColor: Colors.indigo,

          //2. TabBar sits at the bottom of the AppBar layout structure
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home feed'),
              Tab(icon: Icon(Icons.explore), text: 'Explore'),
              Tab(icon: Icon(Icons.settings), text: 'preferences'),
            ],
          ),
        ),

        //3. side slide-out menu panel configuration
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.indigo),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 35, color: Colors.indigo),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Developer Console',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('My Profile'),
                onTap: () =>
                    Navigator.pop(context), // Closes the drawer automatically
              ),
              ListTile(
                leading: const Icon(Icons.analytics),
                title: const Text('Performance Metrics'),
                onTap: () =>
                    Navigator.pop(context), // Closes the drawer automatically
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Exit Lab View'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }, // Closes the drawer automatically
              ),
            ],
          ),
        ),

        //4. TabBarView contains the actual page bodies mapped to each Tab index
        body: const TabBarView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home, size: 64, color: Colors.indigo),
                  SizedBox(height: 10),
                  Text(
                    'Page 1: Primary stream Context',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.explore, size: 64, color: Colors.teal),
                  SizedBox(height: 10),
                  Text(
                    'Page 2: Discover Lab Ele',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.settings, size: 64, color: Colors.orange),
                  SizedBox(height: 10),
                  Text(
                    'Page 1: Primary stream Context',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
