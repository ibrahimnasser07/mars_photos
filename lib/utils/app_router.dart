import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mars_photos/data/repo/repo.dart';
import 'package:mars_photos/logic/mars/mars_cubit.dart';
import 'package:mars_photos/ui/screens/home.dart';
import 'package:mars_photos/utils/router_constants.dart';

import '../ui/screens/landing.dart';
import '../ui/screens/settings.dart';

GoRouter router() {
  final MarsCubit marsCubit = MarsCubit(repo: Repo());

  return GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => BlocProvider<MarsCubit>.value(
          value: marsCubit,
          child: const Landing(),
        ),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => BlocProvider<MarsCubit>.value(
          value: marsCubit,
          child: Home(
            earthDate: state.extra as DateTime?,
          ),
        ),
      ),
      GoRoute(
        path: settingsPath,
        builder: (context, state) => BlocProvider<MarsCubit>.value(
          value: marsCubit,
          child: const Settings(),
        ),
      ),
    ],
  );
}
