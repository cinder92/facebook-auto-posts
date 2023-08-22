import 'package:facebook_auto_posts/database/schema.dart';
import 'package:facebook_auto_posts/widgets/home.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_manager/window_manager.dart';

late Database database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await WindowManager.instance.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitleBarStyle(
      TitleBarStyle.normal,
      windowButtonVisibility: true,
    );
    await windowManager.setMaximumSize(const Size(800, 600));
    await windowManager.setResizable(false);
    await windowManager.show();
    await windowManager.setPreventClose(true);
    await windowManager.setSkipTaskbar(false);
  });

  database = Database();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Facebook Auto-post',
      themeMode: ThemeMode.dark,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: NavigationPaneTheme(
            data: NavigationPaneThemeData(
              backgroundColor: Colors.blue,
            ),
            child: child!,
          ),
        );
      },
      initialRoute: '/',
      home: const HomeScreen(),
    );
  }
}
