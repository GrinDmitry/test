import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_ui/components/category.dart';
import 'package:test_ui/constants.dart';
import 'package:test_ui/components/carousel.dart';
import 'package:test_ui/components/creditCard.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:test_ui/blocs/provider.dart';
import 'package:test_ui/components/helpersUI.dart';


class TopUp extends StatefulWidget {
  @override
  _TopUpState createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of(context);
    final mq = MediaQuery.of(context);

    if (_keyboardIsVisible()) {
      _scrollController.jumpTo(
        mq.viewInsets.bottom,
      );
    }

    return Scaffold(
      appBar: _appBar(context),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                ListView(
                  reverse: false,
                  shrinkWrap: true,
                  controller: _scrollController,
                  children: <Widget>[
                    Category(
                      rowHeight: 100,
                      body: _recentTopUp(_bloc, _contactList),
                      categoryTitle: 'Templates',
                      categoryButtonTitle: 'All templates',
                    ),
                    Divider(),
                    Category(
                      categoryTitle: 'From the card',
                      categoryButtonTitle: 'All cards',
                      rowHeight: 160,
                      body: Carousel(
                        height: 120,
                        items: CardsData().getCards(CardBuildType.MINI),
                        padding: 0,
                        enableSelectionIndicator: false,
                      ),
                    ),
                    PhoneNumberTextField(_bloc),
                    SumTextField(_bloc),
                    getSumOptionsList(_bloc),
                    _keyboardIsVisible() ? SizedBox(height: 70) : SizedBox()
                  ],
                ),
                GestureDetector(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.lightGreen),
                        height: 35,
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }
}

class PhoneNumberTextField extends StatefulWidget {
  final Bloc bloc;

  PhoneNumberTextField(this.bloc);

  @override
  _PhoneNumberTextFieldState createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  StreamSubscription _recentTopUpSubscription;

  final formatter = MaskTextInputFormatter(
      mask: '## ### ## ##', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    _controller.text = _contactList[0].number.substring(4);

    _recentTopUpSubscription = widget.bloc.recentTopUp.listen((newValue) {
      _controller.text = _contactList[newValue].number.substring(4);
      FocusScope.of(context).unfocus();
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _recentTopUpSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 60,
        child: StreamBuilder(
          stream: widget.bloc.numberInputStream,
          builder: (context, AsyncSnapshot<String> textStream) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                cursorColor:
                    textStream.hasError ? Colors.redAccent : Colors.green,
                inputFormatters: [formatter],
                style: TextStyle(fontSize: 16),
                keyboardType: TextInputType.phone,
                onChanged: (String text) {
                  widget.bloc.updateNumber(text);
                  widget.bloc.updateSelected();
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(-8),
                  labelText: 'Phone number',
                  labelStyle: TextStyle(
                      color: _focusNode.hasFocus
                          ? Colors.lightGreen
                          : Colors.grey),
                  hasFloatingPlaceholder: true,
                  prefix: getPrefixIcon(),
                  hintText: '00 000 00 00',
                  suffixIcon: IconButton(
                      icon: ImageIcon(Constants.contact,
                          color: Colors.lightGreen),
                      onPressed: null),
                  errorText: textStream.hasError ? textStream.error : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

_appBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.lightGreen),
        onPressed: () {
          Navigator.of(context).pop();
        }),
    elevation: 0.0,
    backgroundColor: Colors.white,
    bottom: PreferredSize(
        child: Divider(
          thickness: 1,
        ),
        preferredSize: null),
    title: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Top up',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        Text(
          '140 countries',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        )
      ],
    ),
  );
}

_recentTopUp(Bloc bloc, List<Contact> contactList) {
  String _getString(int index) {
    final item = contactList[index];
    if (item.fullName == null) {
      return item.number.substring(0, 7) + '...';
    } else {
      if (item.fullName.length > 9) {
        return item.fullName.substring(0, 7) + '...';
      } else {
        return item.fullName;
      }
    }
  }

  return Container(
    child: StreamBuilder(
      initialData: 0,
      stream: bloc.recentTopUp,
      builder: (context, AsyncSnapshot<int> snapshot) {
        return Container(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: contactList.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Material(
                    color: Colors.white,
                    child: Ink(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                        border: Border.all(
                          width: 3.0,
                          color: getColor(index, snapshot.data),
                        ),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(1000.0),
                        onTap: () {
                          bloc.updateSelected(index);
                          bloc.updateNumber(
                              _contactList[index].number.substring(4));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.person,
                            size: 25.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _getString(index),
                      style: Constants.kContactTextStyle,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

getSumOptionsList(Bloc bloc) {
  return Padding(
    padding: const EdgeInsets.only(left: 7),
    child: Container(
      height: 40,
      child: ListView(
        padding: EdgeInsets.all(5),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          getSumOptionButton(30, bloc),
          getSumOptionButton(50, bloc),
          getSumOptionButton(70, bloc),
          getSumOptionButton(100, bloc)
        ],
      ),
    ),
  );
}

class SumTextField extends StatefulWidget {
  final Bloc bloc;

  SumTextField(this.bloc);

  @override
  _SumTextFieldState createState() => _SumTextFieldState();
}

class _SumTextFieldState extends State<SumTextField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  StreamSubscription _sumOptionSubscription;

  @override
  void initState() {
    _controller.text = '150';

    _sumOptionSubscription = widget.bloc.sumInputStream.listen((newValue) {
      _controller.value = _controller.value.copyWith(text: '$newValue');
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _sumOptionSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          StreamBuilder(
            stream: widget.bloc.sumInputStream,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  cursorColor:
                      snapshot.hasError ? Colors.redAccent : Colors.lightGreen,
                  onChanged: (String text) {
                    widget.bloc.updateSum(text);
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    hintText: '0.00',
                    suffixText: 'UAH',
                    errorText: snapshot.hasError ? snapshot.error : null,
                    labelText: 'Amount',
                    labelStyle: TextStyle(
                        color: _focusNode.hasFocus
                            ? Colors.lightGreen
                            : Colors.grey),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

List<Contact> _contactList = [
  Contact(number: '+38096 818 42 47', fullName: 'My number'),
  Contact(number: '+38063 010 01 01', fullName: 'Kirill Sokolov'),
  Contact(number: '+38097 512 21 35', fullName: 'Radion Petrenko'),
  Contact(number: '+38099 057 21 14'),
];

class Contact {
  Contact({@required this.number, this.fullName, this.avatar});

  final String fullName;
  final String number;
  final CircleAvatar avatar;
}