import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/color.dart';
import 'package:social_app/pages/addpage.dart';
import 'package:social_app/pages/homepage.dart';
import 'package:social_app/pages/profilepage.dart';
import 'package:social_app/pages/searchpage.dart';
import 'package:social_app/provider/user_provider.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int currentIndex = 0;
  PageController pageCon = PageController();
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<UserProvider>(context).isLoad
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: pinkColor,
              ),
            ),
          )
        : Scaffold(
            body: PageView(
              controller: pageCon,
              children: [
                HomePage(),
                AddPage(
                  onNextPage: () {
                    pageCon.jumpToPage(0); // Jump to Home page
                  },
                ),
                SearchPage(),
                ProfilePage()
              ],
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
            ),
            bottomNavigationBar: NavigationBar(
              height: 70,
              selectedIndex: currentIndex,
              backgroundColor: Colors.white.withOpacity(0.3),
              elevation: 0.0,
              onDestinationSelected: (value) {
                setState(() {
                  currentIndex = value;
                  pageCon.jumpToPage(value);
                });
              },
              indicatorColor: pinkColor.withOpacity(0.23),
              destinations: [
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.home_outlined,
                    color: pinkColor,
                  ),
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.add_circle_outline,
                    color: pinkColor,
                  ),
                  icon: Icon(
                    Icons.add_circle_outline,
                  ),
                  label: 'Add',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.search,
                    color: pinkColor,
                  ),
                  icon: Icon(
                    Icons.search,
                  ),
                  label: 'Search',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.person_outline_rounded,
                    color: pinkColor,
                  ),
                  icon: Icon(
                    Icons.person_outline_rounded,
                  ),
                  label: 'Profile',
                )
              ],
            ),
          );
  }
}
