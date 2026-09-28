import 'package:flutter/material.dart';

import '../topics/01_stateless_basic.dart';
import '../topics/02_stateful_counter.dart';
import '../topics/03_dynamic_list.dart';
import '../topics/04_grid_layout.dart';
import '../topics/05_form_validation.dart';
import '../topics/06_data_passing.dart';
import '../topics/07_network_calls.dart';
import '../topics/08_theme_toggle.dart';
import '../topics/09_navigation_hubs.dart';
import '../topics/10_local_storage.dart';

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Achitecture Index'),
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.layers),
              title: const Text('Topic 1: Static layouts'),
              subtitle: Text('Understanding Container,Row and Column'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                //Navigator manager the screen navidation stack
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StaticLayoutScreen()),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.layers),
              title: const Text('Topic 2: Stateful Interactivity'),
              subtitle: const Text(
                'using setState with Buttons, Switches, and Inputs',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InteractiveLabScreen(),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.format_list_bulleted),
              title: const Text('topic 3: Dynamic Scrollable List'),
              subtitle: const Text(
                'efficient memory optimization using Listview.bulider',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DynamicListScreen()), // wait! remove 'const' if you modify it later , but her it work since the class is stateless!
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.grid_view),
              title: const Text('Topic 4: Grid Layout'),
              subtitle: const Text(
                'two-column espostive item grid using GridView.builder',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GridLayoutScreen()),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.assignment_turned_in),
              title: const Text('Topic 5: Form Validation '),
              subtitle: const Text(
                'Safe text extraction using GlobalKey and validation rules',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormValidationScreen(),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.move_up),
              title: const Text('Topic 6: Data Passing'),
              subtitle: const Text(
                'Carrying variable states through widget constructors',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataPassingScreenA()),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.cloud_download),
              title: const Text('Topic 7: network API calls'),
              subtitle: const Text(
                'Fetching asynchronous JSON data with FutureBuilder',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NetworkCallScreen()),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.palette),
              title: const Text('Topic 8: Global App Theme'),
              subtitle: const Text(
                'Toggling light and dark application mode styles programmatically',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThemeToggleScreen(
                      isDarkMode: isDarkMode,
                      onThemeChanged: onThemeChanged,
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.view_carousel),
              title: const Text('Topic 9: Navigation Hubs'),
              subtitle: const Text(
                'Implementing side drawers and responsive multi-tab view systems',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NavigationHubScreen(),
                  ),
                );
              },
            ),
          ),

          Card(
            chils:ListTile(
              leading: const Icon(Icons.save),
              title: const Text('Topic 10: Local Disk Storage'),
              subtitle: const Text('Persisting user settings data strings using shared_preferences'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocalStorageScreen(),
                  ),
                );
              }
            )
          )
        ],
      ),
    );
  }
}
