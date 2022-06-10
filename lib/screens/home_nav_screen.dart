import 'package:fedha_zangu/screens/account_screen.dart';
import 'package:fedha_zangu/screens/bajeti_screen.dart';
import 'package:fedha_zangu/screens/cash_flow_screen.dart';
import 'package:fedha_zangu/screens/debts_screen.dart';
import 'package:fedha_zangu/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeNavScreen extends StatefulWidget {
  final index;
  HomeNavScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<HomeNavScreen> createState() => _HomeNavScreenState();
}

class _HomeNavScreenState extends State<HomeNavScreen> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    updateNav();
    // _pageController = PageController();
  }

  void updateNav() {
    setState(() {
      _currentIndex = widget.index;
      // _pageController.jumpTo(double.parse(_currentIndex));
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            HomeScreen(),
            CashFlowScreen(),
            BajetiScreen(),
            DebtsScreen(),
            AccountScreen()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Mwanzo'),
              activeColor: Colors.deepPurple,
              icon: Icon(Icons.home)),
          BottomNavyBarItem(
              title: Text('Mzunguko'),
              activeColor: Colors.deepPurple,
              icon: Icon(Icons.currency_exchange)),
          BottomNavyBarItem(
              title: Text('Bajeti'),
              activeColor: Colors.deepPurple,
              icon: Icon(Icons.pie_chart)),
          BottomNavyBarItem(
              title: Text('Madeni'),
              activeColor: Colors.deepPurple,
              icon: Icon(Icons.money)),
          BottomNavyBarItem(
              title: Text('Akaunti'),
              activeColor: Colors.deepPurple,
              icon: Icon(Icons.account_circle))
        ],
      ),
    );
  }
}
