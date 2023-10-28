import 'package:go_router/go_router.dart';
import 'package:mars_photos/ui/screens/home.dart';
import 'package:mars_photos/utils/router_constants.dart';

import '../ui/screens/settings.dart';

GoRouter router() {
  return GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: settingsPath,
        builder: (context, state) => const Settings(),
      ),
    ],
  );
}
