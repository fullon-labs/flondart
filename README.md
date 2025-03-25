# flondart


A library for FLON Node API

It talks to a FLON node on the given RPC endpoint and API method.


## Usage

A simple usage example:

```dart
import 'package:flondart/flondart.dart';

main() {
  FLONClient client = FLONClient('https://127.0.0.1:8888', 'v1');

  // Get FLON Node Info
  client.getInfo().then((NodeInfo nodeInfo) {
    print(nodeInfo);
  });

  // Get FLON Abi
  client.getAbi('flon.token').then((AbiResp abi) {
    print(abi);
  });

  // Get FLON Raw Abi
  client.getRawAbi('flon.token').then((AbiResp abi) {
    print(abi);
  });

  // Get FLON Raw code and Abi
  client.getRawCodeAndAbi('flon.token').then((AbiResp abi) {
    print(abi);
  });

  // Get FLON Block Info
  client.getBlock('298674').then((Block block) {
    print(block);
  });

  // Get Account Info
  client.getAccount('flon.token').then((Account account) {
    print(account);
  });

  // Get Account Actions
  client.getActions('flon.token', pos: -1, offset: -1).then((Actions actions) {
    print(actions);
  });

  // Get Transaction
  client
      .getTransaction(
          '83875faeb054ba20b20f392418e3a0002c4bb1c36cc4e3fde15cbd0963da8a15')
      .then((TransactionBlock transaction) {
    print(transaction);
  });

  // Get Accounts from public key
  client
      .getKeyAccounts('FU8RWQpzzMi5uFXXXAChi4dHnyxMYKKdAQ3Y3pHQTrvhzGk95LbT')
      .then((AccountNames accountNames) {
    print(accountNames);
  });

  // Get currency balance
  client
      .getCurrencyBalance('parslseed123', 'newdexpocket')
      .then((List<Holding> balance) {
    print(balance);
  });
}
```

## Push Transaction

```dart
import 'package:flondart/flondart.dart';

main() {
  FLONClient client = FLONClient('http://127.0.0.1:8888', 'v1',
      privateKeys: ["5J9b3xMkbvcT6gYv2EpQ8FD4ZBjgypuNKwE1jxkd7Wd1DYzhk88"]);

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

  List<Action> actions = [
    Action()
      ..account = 'flon.token'
      ..name = 'transfer'
      ..authorization = auth
      ..data = data
  ];

  Transaction transaction = Transaction()..actions = actions;

  // will print something like:
  // {transaction_id: c28bf8c168741adb96f3aef8723e953140cc60ecd20cec0d22e5a2dc5cdd5571, processed: {id: c28bf8c168741adb96f3aef8723e953140cc60ecd20cec0d22e5a2dc5cdd5571, block_num: 576745, block_time: 2019-05-03T06:07:54.500, producer_block_id: null, receipt: {status: executed, cpu_usage_us: 216, net_usage_words: 16}, elapsed: 216, net_usage: 128, scheduled: false, action_traces: [{receipt: {receiver: flon.token, act_digest: 117d5840be4ff21fad764d5d497182916f76e772b279e65e964bccfa7c888331, global_sequence: 576794, recv_sequence: 17, auth_sequence: [[bob, 37]], code_sequence: 1, abi_sequence: 1}, act: {account: flon.token, name: transfer, authorization: [{actor: bob, permission: active}], data: {from: bob, to: alice, quantity: 0.0001 SYS, memo: }, hex_data: 0000000000000e3d0000000000855c340100000000000000045359530000000000}, context_free: false, elapsed: 73, console: , trx_id: c28bf8c168741adb96f3aef8723e953140cc60ecd20cec0d22e5a2dc5cdd5571, block_num: 576745, block_time: 2019-05-03T06:07:54.500, producer_block_id: null, account_ram_deltas: [], except: null, inline_traces: [{receipt: {receiver: bob, act_digest: 117d5840be4ff21fad764d5d497182916f76e772b279e65e964bccfa7c888331, global_sequence: 576795, recv_sequence: 14, auth_sequence: [[bob, 38]], code_sequence: 1, abi_sequence: 1}, act: {account: flon.token, name: transfer, authorization: [{actor: bob, permission: active}], data: {from: bob, to: alice, quantity: 0.0001 SYS, memo: }, hex_data: 0000000000000e3d0000000000855c340100000000000000045359530000000000}, context_free: false, elapsed: 2, console: , trx_id: c28bf8c168741adb96f3aef8723e953140cc60ecd20cec0d22e5a2dc5cdd5571, block_num: 576745, block_time: 2019-05-03T06:07:54.500, producer_block_id: null, account_ram_deltas: [], except: null, inline_traces: []}, {receipt: {receiver: alice, act_digest: 117d5840be4ff21fad764d5d497182916f76e772b279e65e964bccfa7c888331, global_sequence: 576796, recv_sequence: 15, auth_sequence: [[bob, 39]], code_sequence: 1, abi_sequence: 1}, act: {account: flon.token, name: transfer, authorization: [{actor: bob, permission: active}], data: {from: bob, to: alice, quantity: 0.0001 SYS, memo: }, hex_data: 0000000000000e3d0000000000855c340100000000000000045359530000000000}, context_free: false, elapsed: 2, console: , trx_id: c28bf8c168741adb96f3aef8723e953140cc60ecd20cec0d22e5a2dc5cdd5571, block_num: 576745, block_time: 2019-05-03T06:07:54.500, producer_block_id: null, account_ram_deltas: [], except: null, inline_traces: []}]}], except: null}}
  client.pushTransaction(transaction, broadcast: true).then((trx) {
    print(trx);
  });
}

```

## Installing

https://pub.dartlang.org/packages/flondart#-installing-tab-


## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/fullon-labs/flondart/issues
