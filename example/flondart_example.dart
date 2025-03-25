import 'package:flondart/flondart.dart';

main() {
  FLONClient client = FLONClient('http://127.0.0.1:8888', 'v1');

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

  // Get Tables
  client.getTableRows('flon', 'flon', 'abihash').then((rows) => print(rows));
  client.getTableRow('flon', 'flon', 'abihash').then((row) => print(row));
}
