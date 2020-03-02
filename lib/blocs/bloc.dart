import 'dart:async';


class Bloc {

  var _numberInputController = StreamController<String>.broadcast();
  var _didSelectRecentTopUp = StreamController<int>.broadcast();
  var _sumInputController = StreamController<String>.broadcast();

  Stream<String> get numberInputStream => _numberInputController.stream;
  Stream<int> get recentTopUp => _didSelectRecentTopUp.stream;
  Stream<String> get sumInputStream => _sumInputController.stream;

  dispose() {
    _numberInputController.close();
    _didSelectRecentTopUp.close();
    _sumInputController.close();
  }

  updateNumber(String text) {
    if (text == null || text == '' || text.length < 9) {
      _numberInputController.sink.addError('Phone number is too short');
    } else {
      _numberInputController.sink.add(text);
    }
  }

  updateSelected([int index]) {
    _didSelectRecentTopUp.sink.add(index);
  }

  updateSum(String text) {
    if (text == null || text == '') {
      _sumInputController.addError('Field should be filled in');
    } else {
      _sumInputController.sink.add(text);
    }
  }
}