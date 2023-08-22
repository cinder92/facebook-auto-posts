import 'package:facebook_auto_posts/pages/accounts.dart';
import 'package:facebook_auto_posts/pages/dashboard.dart';
import 'package:facebook_auto_posts/pages/groups.dart';
import 'package:facebook_auto_posts/pages/posts.dart';
import 'package:fluent_ui/fluent_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _paneIndex = 0;

  void _handleItemTap(int index) => setState(() => _paneIndex = index);

  final List<NavigationPaneItem> leftItems = [
    PaneItem(
      key: const ValueKey('/'),
      title: const Text('Dashboard'),
      icon: const Icon(FluentIcons.home),
      body: const DashboardScreen(),
    ),
    PaneItem(
      key: const ValueKey('/groups'),
      title: const Text('Grupos'),
      icon: const Icon(FluentIcons.group_list),
      body: const GroupsPage(),
    ),
    PaneItem(
      key: const ValueKey('/posts'),
      title: const Text('Publicaciones'),
      icon: const Icon(FluentIcons.post_update),
      body: const PostsPage(),
    ),
    PaneItem(
      key: const ValueKey('/accounts'),
      title: const Text('Cuentas'),
      icon: const Icon(FluentIcons.accounts),
      body: const AccountsPage(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
        automaticallyImplyLeading: false,
        title: Text('Facebook Auto-posts'),
      ),
      pane: NavigationPane(
        selected: _paneIndex,
        displayMode: PaneDisplayMode.auto,
        indicator: const EndNavigationIndicator(),
        onChanged: (index) => _handleItemTap(index),
        items: leftItems,
      ),
    );
  }
}
