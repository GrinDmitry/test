import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_ui/constants.dart';

enum CardBuildType { DETAILED, MINI }

class CreditCard {
  final String name;
  final String number;
  final String expirationDate;
  final String balance;
  final Image service;
  final Image applepaySupport;

  CreditCard(
      {@required this.name,
      @required this.number,
      @required this.expirationDate,
      @required this.balance,
      @required this.service,
      this.applepaySupport});
}

class CardsData {
  final List<CreditCard> _list = [
    CreditCard(
      name: Constants.universal,
      expirationDate: '10/21',
      number: '4149 **** **** *007',
      balance: '7 443 UAH',
      applepaySupport: Constants.applePay,
      service: Constants.mastercard,
    ),
    CreditCard(
      name: Constants.debit,
      expirationDate: '10/21',
      number: '4149 **** **** *015',
      balance: '0 USD',
      applepaySupport: Constants.applePay,
      service: Constants.visa,
    ),
    CreditCard(
      name: Constants.junior,
      expirationDate: '10/21',
      number: '4149 **** **** *024',
      balance: '500 UAH',
      applepaySupport: Constants.applePay,
      service: Constants.mastercard,
    ),
  ];

  List<Widget> getCards(CardBuildType type) {
    List<Widget> output = [];

    for (CreditCard card in _list) {
      if (type == CardBuildType.DETAILED) {
        final item = DetailedCreditCard(card: card);
        output.add(item);
      } else if (type == CardBuildType.MINI) {
        final item = MiniCreditCard(card: card);
        output.add(item);
      }
    }

    return output;
  }
}

class DetailedCreditCard extends StatelessWidget {
  final CreditCard card;

  DetailedCreditCard({@required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: AssetImage('assets/milkyway.jpg'), fit: BoxFit.cover),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          '${card.name}',
                          style: Constants.kCardTextStyle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Container(
                        width: 40,
                        child: card.applepaySupport,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text(
                    '${card.number}',
                    style: Constants.kCardSubTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                  child: Text(
                    '${card.expirationDate}',
                    style: Constants.kCardSubTextStyle,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${card.balance}',
                    style: Constants.kCardTextStyle,
                  ),
                  Container(
                    width: 40,
                    child: card.service,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MiniCreditCard extends StatelessWidget {
  final CreditCard card;

  MiniCreditCard({@required this.card});

  @override
  Widget build(BuildContext context) {
    final lastFour = card.number.substring(card.number.length - 4);
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey[400],
              width: 0.4,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(1, 3), blurRadius: 5)
            ]),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage('assets/milkyway.jpg'),
                        fit: BoxFit.cover),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, bottom: 5),
                      child: Container(
                          width: 40,
                          child:
                              FittedBox(fit: BoxFit.fill, child: card.service)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text('$lastFour  ${card.name}',
                          style: TextStyle(fontSize: 18)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${card.balance}',
                      style: TextStyle(
                          fontFamily: 'SanFrancisco',
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
