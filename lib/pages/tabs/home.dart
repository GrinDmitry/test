import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_ui/components/carousel.dart';
import 'package:test_ui/components/creditCard.dart';
import 'package:test_ui/components/slideUpMenu.dart';
import 'package:test_ui/constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: IconButton(icon: ImageIcon(Constants.wallet, size: 20, color: Colors.lightGreen,), onPressed: null),
                  trailing: Icon(Icons.navigate_next),
                  title: Align(
                    alignment: Alignment(-1.15, 0),
                    child: Text('Wallet', style: TextStyle(fontSize: 18))),
                ),
                Carousel(
                  height: 220,
                  items: CardsData().getCards(CardBuildType.DETAILED),
                  padding: 7,
                  enableSelectionIndicator: true,
                ),
              ],
            ),
            SlideUpMenu(
              initialPosition: MediaQuery.of(context).size.height * 0.5,
              menuHeight: 600,
              content: gridView(),
            )
          ],
        ),
      ),
    );
  }
}

AppBar createAppBar() {
  final myAppBar = AppBar(
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleSpacing: 0.0,
    automaticallyImplyLeading: false,
    centerTitle: true,
    bottom: PreferredSize(
      child: Divider(
        thickness: 1,
      ),
      preferredSize: null,
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(icon: Constants.identity, onPressed: null),
        ),
        SizedBox(
          width: 40,
        ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(text: '\$ ', style: TextStyle(color: Colors.grey)),
                    TextSpan(text: '24.30 '),
                    TextSpan(text: '/ ', style: TextStyle(color: Colors.grey)),
                    TextSpan(text: '24.51')
                  ]),
            ),
          ),
        )
      ],
    ),
    actions: <Widget>[
      Row(
        children: <Widget>[
          IconButton(
              icon: Icon(
                FontAwesomeIcons.solidThumbsUp,
                color: Colors.orange,
              ),
              onPressed: null),
          IconButton(icon: Constants.chat, onPressed: null)
        ],
      )
    ],
  );
  return myAppBar;
}
