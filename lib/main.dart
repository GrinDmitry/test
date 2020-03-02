import 'package:flutter/material.dart';
import 'package:test_ui/pages/topUp.dart';
import 'pages/tabs/home.dart';
import 'pages/tabs/notifications.dart';
import 'pages/tabs/qr.dart';
import 'pages/tabs/transactions.dart';
import 'pages/tabs/services.dart';
import 'constants.dart';
import 'package:test_ui/blocs/provider.dart';
import 'package:test_ui/components/helpersUI.dart';

void main() {
  runApp(Privat24());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Privat24 extends StatefulWidget {

  @override
  _Privat24State createState() => _Privat24State();
}

class _Privat24State extends State<Privat24> {
  int _selectedPage = 0;
  
  final _pageOptions = [
    Home(),
    Services(),
    QR(),
    Transactions(),
    Notifications(),
  ];

  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
        theme: getThemeData(),
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        routes: {
          '/onHome' : (context) => Home(),
          '/onTopUp': (context) => TopUp()
        },
        home: Scaffold(
          body: _pageOptions[_selectedPage],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedPage,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.lightGreen,
            unselectedItemColor: Colors.grey[300],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (int index) {
              setState(() {
                _selectedPage = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: ImageIcon(Constants.onHome), title: Text('')),
              BottomNavigationBarItem(
                  icon: ImageIcon(Constants.onServices), title: Text('')),
              BottomNavigationBarItem(
                  icon: ImageIcon(Constants.onQR), title: Text('')),
              BottomNavigationBarItem(
                  icon: ImageIcon(Constants.onTransactions), title: Text('')),
              BottomNavigationBarItem(
                  icon: ImageIcon(Constants.onNotification), title: Text(''))
            ],
          ),
        ),
      ),
    );
  }
}

