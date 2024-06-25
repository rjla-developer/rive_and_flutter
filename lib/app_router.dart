import 'package:flutter/material.dart';

// GoRouter:
import 'package:go_router/go_router.dart';

// Widgets:
import 'package:rive_and_flutter/main_wrapper.dart';

// Screens:
import 'package:rive_and_flutter/screens/profile_screen/profile_screen.dart';
import 'package:rive_and_flutter/screens/profile_screen/screens/edit_profile.dart';
import 'package:rive_and_flutter/screens/profile_screen/screens/screens/change_age.dart';
import 'package:rive_and_flutter/screens/settings_screen/settings_screen.dart';
import 'package:rive_and_flutter/screens/home_screen/home_screen.dart';
import 'package:rive_and_flutter/screens/help_screen/help_screen.dart';

class AppNavigation {
  AppNavigation._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorTime = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainWrapper(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(navigatorKey: _rootNavigatorTime, routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const HomeScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            ),
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const ProfileScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
              ),
              routes: [
                GoRoute(
                    path: 'edit-profile',
                    name: 'Edit profile',
                    pageBuilder: (context, state) => CustomTransitionPage(
                          key: state.pageKey,
                          child: const EditProfileScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                    routes: [
                      GoRoute(
                          path: ':age',
                          pageBuilder: (context, state) {
                            final ageString = state.pathParameters['age'];
                            final age = ageString != null
                                ? int.tryParse(ageString)
                                : null;
                            return CustomTransitionPage(
                              key: state.pageKey,
                              child: ChangeAgeScreen(
                                age: age!,
                              ),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(1, 1),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                );
                              },
                            );
                          })
                    ]),
              ],
            ),
            GoRoute(
              path: '/settings',
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const SettingsScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return PositionedTransition(
                    rect: RelativeRectTween(
                      begin: const RelativeRect.fromLTRB(0, 0, 0, 0),
                      end: const RelativeRect.fromLTRB(0, 0, 0, 0),
                    ).animate(animation),
                    child: child,
                  );
                },
              ),
            ),
          ])
        ],
      ),
      GoRoute(
        path: '/help',
        name: 'HELP',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HelpScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
        ),
      ),
    ],
  );
}
