import 'package:flondart/flondart.dart';

main() {
  FLONClient client = FLONClient('http://127.0.0.1:8888', 'v1',
      privateKeys: ["5J9b3xMkbvcT6gYv2EpQ8FD4ZBjgypuNKwE1jxkd7Wd1DYzhk88"]);

  //privateKeys can also be set after client was constructed, as following
  //client.privateKeys = ["5J9b3xMkbvcT6gYv2EpQ8FD4ZBjgypuNKwE1jxkd7Wd1DYzhk88"];

  List<Authorization> auth = [
    Authorization()
      ..actor = 'xuelongqy2cn'
      ..permission = 'active'
  ];

  Map data = {
    'creator': 'xuelongqy2cn',
    'name': 'xuelongqy3cn',
    'owner': {
      'threshold': 1,
      'keys': [
        {
          'key': "FU65xaKR6zw4cjy9kuwuCbi7vTTbWNYSHdVgNf7492VAjCPi6gT6",
          'weight': 1,
        }
      ],
      'accounts': [],
      'waits': []
    },
    'active': {
      'threshold': 1,
      'keys': [
        {
          'key': "FU65xaKR6zw4cjy9kuwuCbi7vTTbWNYSHdVgNf7492VAjCPi6gT6",
          'weight': 1,
        }
      ],
      'accounts': [],
      'waits': []
    },
  };

  List<Action> actions = [
    Action()
      ..account = 'flon'
      ..name = 'newaccount'
      ..authorization = auth
      ..data = data,
    Action()
      ..account = 'flon.token'
      ..name = 'transfer'
      ..authorization = auth
      ..data = {
        'from': "xuelongqy2cn",
        'to': "xuelongqy3cn",
        'quantity': "0.01 FLON",
        'memo': ""
      }
  ];

  Transaction transaction = Transaction()..actions = actions;

  // print result
  client.pushTransaction(transaction, broadcast: true).then((trx) {
    print(trx);
  });
}
