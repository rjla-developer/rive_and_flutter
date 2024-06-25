import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';

//Rive:
import 'package:rive/rive.dart';

//Rive Utils:
import 'package:rive_and_flutter/utils/rive_utils.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  RiveAsset selectedBottomNav = bottomNavs[1];

  void _goToBranch(String targetScreen) {
    context.go(selectedBottomNav.targetScreen);
  }

  void _navButtonAction(index) {
    {
      if (bottomNavs[index] != selectedBottomNav) {
        setState(() => selectedBottomNav = bottomNavs[index]);
      }
      bottomNavs[index].input!.change(true);
      Future.delayed(const Duration(seconds: 1), () {
        bottomNavs[index].input!.change(false);
      });
      _goToBranch(bottomNavs[index].targetScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      topNavigation: SlotLayout(
        config: {
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key('main-desktop'),
            builder: (context) {
              return Material(
                color: const Color.fromARGB(255, 36, 143, 83),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                  child: Row(
                    children: [
                      Text(
                        selectedBottomNav.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      ...List.generate(
                        bottomNavs.length,
                        (index) => GestureDetector(
                          onTap: () => _navButtonAction(index),
                          child: Row(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Opacity(
                                      opacity:
                                          selectedBottomNav == bottomNavs[index]
                                              ? 1
                                              : 0.5,
                                      child: RiveAnimation.asset(
                                        bottomNavs[index].src,
                                        artboard: bottomNavs[index].artboard,
                                        onInit: (artboard) {
                                          StateMachineController controller =
                                              RiveUtils.getRiveController(
                                                  artboard,
                                                  stateMachineName:
                                                      bottomNavs[index]
                                                          .stateMachineName);
                                          bottomNavs[index].input = controller
                                              .findSMI("active") as SMIBool;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 12),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        },
      ),
      body: SlotLayout(
        config: {
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key('content-desktop'),
            builder: (context) {
              return widget.navigationShell;
            },
          ),
        },
      ),
      bottomNavigation: SlotLayout(
        config: {
          Breakpoints.small: SlotLayout.from(
            key: const Key('main-mobile'),
            builder: (context) {
              return Scaffold(
                body: widget.navigationShell,
                bottomNavigationBar: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 62, 98, 128),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...List.generate(
                          bottomNavs.length,
                          (index) => GestureDetector(
                            onTap: () => _navButtonAction(index),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  height: 4,
                                  width: selectedBottomNav == bottomNavs[index]
                                      ? 20
                                      : 0,
                                  margin: const EdgeInsets.only(bottom: 4),
                                  decoration: BoxDecoration(
                                    color:
                                        selectedBottomNav == bottomNavs[index]
                                            ? const Color.fromARGB(
                                                255, 255, 255, 255)
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  curve: Curves.decelerate,
                                ),
                                SizedBox(
                                  height: 36,
                                  width: 36,
                                  child: Opacity(
                                    opacity:
                                        selectedBottomNav == bottomNavs[index]
                                            ? 1
                                            : 0.5,
                                    child: RiveAnimation.asset(
                                      bottomNavs[index].src,
                                      artboard: bottomNavs[index].artboard,
                                      onInit: (artboard) {
                                        StateMachineController controller =
                                            RiveUtils.getRiveController(
                                                artboard,
                                                stateMachineName:
                                                    bottomNavs[index]
                                                        .stateMachineName);
                                        bottomNavs[index].input = controller
                                            .findSMI("active") as SMIBool;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        },
      ),
    );
  }
}

class RiveAsset {
  final String src, artboard, stateMachineName, title, targetScreen;
  late SMIBool? input;

  RiveAsset(this.src,
      {required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.targetScreen = '/',
      this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset("assets/icons.riv",
      artboard: "SETTINGS",
      stateMachineName: "SETTINGS_Interactivity",
      title: "Settings",
      targetScreen: '/settings'),
  RiveAsset("assets/icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
      title: "Home",
      targetScreen: '/'),
  RiveAsset("assets/icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "Profile",
      targetScreen: '/profile')
];
