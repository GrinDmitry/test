import 'package:flutter/material.dart';

class Constants {
  static TextStyle kCardTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      fontFamily: 'SanFrancisco');

  static TextStyle kCardSubTextStyle =
      TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'SanFrancisco');
  
  static TextStyle kContactTextStyle = TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600);
  static TextStyle kCategoryTitleStyle = TextStyle(color: Colors.grey, fontSize: 11);
  static TextStyle kCategoryButtonTitleStyle = TextStyle(color: Colors.lightGreen, fontSize: 11);

  static Image applePay = Image.asset('assets/applepay.jpg');
  static Image visa = Image.asset('assets/visa.png');
  static Image mastercard = Image.asset('assets/mastercard.png');
  static Image addService = Image.asset('assets/addService.png');
  static Image payments = Image.asset('assets/payments.png');
  static Image toCard = Image.asset('assets/toCard.png');
  static Image topUp = Image.asset('assets/topUp.png');
  static Image identity = Image.asset('assets/identity.png');
  static Image chat = Image.asset('assets/chat.png');
  static Image ukraineFlag = Image.asset('assets/ukraine.png');
  static AssetImage contact = AssetImage('assets/contact.png');
  static AssetImage wallet = AssetImage('assets/wallet.png');
  static AssetImage onHome = AssetImage('assets/onHome.png');
  static AssetImage onTransactions = AssetImage('assets/onTransactions.png');
  static AssetImage onServices = AssetImage('assets/onServices.png');
  static AssetImage onNotification = AssetImage('assets/onNotification.png');
  static AssetImage onQR = AssetImage('assets/onQR.png');

  static String universal = 'Universal Card';
  static String debit = 'Card for payments';
  static String junior = 'Junior';
  static String gold = 'Gold';
  static String platinum = 'Platinum';
}