import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:youfirst/core/app_router.dart';

@RoutePage(name: 'AppScaffold')
class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      // list of your tab routes
      // routes used here must be declared as children
      // routes of /dashboard
      routes: const [
        HomeRoute(),
        ProfileRoute(),
        // TherapyRoute(),
        // QuestionRoute(),
      ],
      // transitionBuilder: (context, child, animation) => FadeTransition(
      //   opacity: animation,
      //   // the passed child is technically our animated selected-tab page
      //   child: child,
      // ),
      builder: (context, child) {
        // obtain the scoped TabsRouter controller using context
        final tabsRouter = AutoTabsRouter.of(context);
        // tabsRouter.notifyAll(forceUrlRebuild: true);
        // Here we're building our Scaffold inside of AutoTabsRouter
        // to access the tabsRouter controller provided in this context
        //
        // alternatively, you could use a global key
        return Scaffold(
          body: child,
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.circular(31),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(31),
              ),
              child: GNav(
                tabMargin: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                selectedIndex: tabsRouter.activeIndex,
                onTabChange: (index) {
                  // here we switch between tabs
                  tabsRouter.setActiveIndex(index);
                  tabsRouter.notifyAll(forceUrlRebuild: false);
                },
                gap: 4,
                activeColor: Color(0xffAEAFF7),
                color: Colors.white,
                backgroundColor: Color(0xffAEAFF7),
                tabBorderRadius: 50,
                tabs: const [
                  GButton(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    icon: Icons.home,
                    text: 'Home',
                    backgroundColor: Color(0xffFFFFFF),
                  ),
                  GButton(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    icon: Icons.person,
                    text: 'Profile',
                    backgroundColor: Color(0xffFFFFFF),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
