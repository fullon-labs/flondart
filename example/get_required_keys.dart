import 'package:flondart/flondart.dart';

main() {
  FLONClient client = FLONClient('http://127.0.0.1:8888', 'v1');

  List<Authorization> auth = [
    Authorization()
      ..actor = 'bob'
      ..permission = 'active'
  ];

  Map data = {
    'from': 'bob',
    'to': 'alice',
    'quantity': '0.0001 SYS',
    'memo': '',
  };

  List<Authorization> auth2 = [
    Authorization()
      ..actor = 'alice'
      ..permission = 'active'
  ];

  Map data2 = {
    'from': 'alice',
    'to': 'bob',
    'quantity': '0.0002 SYS',
    'memo': '',
  };

  List<Action> actions = [
    Action()
      ..account = 'flon.token'
      ..name = 'transfer'
      ..authorization = auth
      ..data = data,
    Action()
      ..account = 'flon.token'
      ..name = 'transfer'
      ..authorization = auth2
      ..data = data2
  ];

  Transaction transaction = Transaction()..actions = actions;

  List<String> availableKeys = [
    "FU8Qi58kbERkTJC7A4gabxYU4SbrAxStJHacoke4sf6AvJyEDZXj",
    "FU5hF6jM5otV3jYdLVWqQ2Lidpb7LtN8dsXsFHFocggzvfGHGfR1"
  ];
  client.getRequiredKeys(transaction, availableKeys).then((RequiredKeys rkeys) {
    print(rkeys);
  });
}
