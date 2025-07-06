import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flondart_ecc/flondart_ecc.dart' as ecc;
import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../flondart.dart';
import 'serialize.dart' as ser;

/// FLONClient calls APIs against given FLON nodes
class FLONClient {
  String _nodeURL;
  final String _version;
  late int expirationInSec;

  // Map<String, ecc.FLONPrivateKey> keys = Map();

  /// Converts abi files between binary and structured form (`abi.abi.json`) */
  // late Map<String, Type> abiTypes;
  late Map<String, Type> transactionTypes;
  String? chainId;

  String get currentChainId => chainId ?? mainChainId;
  final mainChainId =
      'd4019d7d8633a337973408c6c00e5c4888933ad1b6ce10edddea8145317d8d12';

  /// Construct the FLON client from FLON node URL
  FLONClient(
    this._nodeURL,
    this._version, {
    this.expirationInSec = 180,
  }) {
    //_mapKeys(privateKeys);

    // abiTypes = ser.getTypesFromAbi(
    //     ser.createInitialTypes(), Abi.fromJson(json.decode(abiJson)));
    transactionTypes = ser.getTypesFromAbi(
        ser.createInitialTypes(), Abi.fromJson(json.decode(transactionJson)));
  }

  String get nodeURL => _nodeURL;

  set nodeURL(String value) {
    _nodeURL = value;
  }

  /// Sets private keys. Required to sign transactions.
  void _mapKeys(
      Map<String, ecc.FLONPrivateKey> keys, List<String> privateKeys) {
    for (String privateKey in privateKeys) {
      ecc.FLONPrivateKey pKey = ecc.FLONPrivateKey.fromString(privateKey);
      String publicKey = pKey.toFLONPublicKey().toString();
      keys[publicKey] = pKey;
    }
  }

  // set privateKeys(List<String> privateKeys) => _mapKeys(privateKeys);

  Future _post(String path, Object body,
      {int httpTimeout = 20, int retryCount = 0, Completer? completer}) async {
    var encode;
    if (completer == null) {
      completer = Completer();
      encode = json.encode(body);
    } else {
      encode = body;
    }
    Uri parse;
    if (!path.contains('https')) {
      parse = Uri.parse('${this._nodeURL}/${this._version}${path}');
    } else {
      parse = Uri.parse(path);
    }

    http
        .post(parse, body: encode)
        .timeout(Duration(seconds: httpTimeout))
        .then((http.Response response) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      String responseString = utf8decoder.convert(response.bodyBytes);
      if (response.statusCode >= 300) {
        if ((responseString.toString().contains('"code":3080005,') ||
                responseString.toString().contains('"code":3080006,') ||
                responseString.toString().contains('"code":3081001,') ||
                responseString.toString().contains('"code":3080004,') ||
                (responseString.toLowerCase().contains('billed') &&
                    responseString.toLowerCase().contains('cpu') &&
                    responseString.toLowerCase().contains('billable'))) &&
            retryCount < 2) {
          retryCount++;
          _post(path, encode,
              httpTimeout: httpTimeout,
              retryCount: retryCount,
              completer: completer);
        } else {
          completer!.completeError(responseString);
        }
      } else {
        completer!.complete(json.decode(responseString));
      }
    }).catchError((error, stackTrace) {
      completer!.completeError(error.toString());
    });
    return completer.future;
  }

  // ignore: unused_element
  Future _get(String path, {int httpTimeout = 20}) async {
    Completer completer = Completer();
    Uri parse;
    if (!path.contains('https')) {
      parse = Uri.parse('${this._nodeURL}/${this._version}${path}');
    } else {
      parse = Uri.parse(path);
    }
    http
        .get(parse)
        .timeout(Duration(seconds: httpTimeout))
        .then((http.Response response) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      String responseString = utf8decoder.convert(response.bodyBytes);
      if (response.statusCode >= 300) {
        completer.completeError(responseString);
      } else {
        completer.complete(json.decode(responseString));
      }
    }).catchError((error, stackTrace) {
      completer.completeError(error.toString());
    });
    return completer.future;
  }

  /// Get FLON Node Info
  Future<NodeInfo> getInfo() async {
    return this._post('/chain/get_info', {}).then((nodeInfo) {
      NodeInfo info = NodeInfo.fromJson(nodeInfo);
      if (chainId == null) {
        chainId = info.chainId;
      }
      return info;
    });
  }

  /// Get table rows (FLON get table ...)
  Future<List<Map<String, dynamic>>> getTableRows(
    String code,
    String scope,
    String table, {
    bool json = true,
    String tableKey = '',
    String lower = '',
    String upper = '',
    int indexPosition = 1,
    String keyType = '',
    int limit = 10,
    bool reverse = false,
  }) async {
    dynamic result = await this._post('/chain/get_table_rows', {
      'json': json,
      'code': code,
      'scope': scope,
      'table': table,
      'table_key': tableKey,
      'lower_bound': lower,
      'upper_bound': upper,
      'index_position': indexPosition,
      'key_type': keyType,
      'limit': limit,
      'reverse': reverse,
    });
    if (result is Map) {
      return result['rows'].cast<Map<String, dynamic>>();
    }
    return [];
  }

  Future<Map<String, dynamic>> getTableRows2(
    String code,
    String scope,
    String table, {
    bool json = true,
    String tableKey = '',
    String lower = '',
    String upper = '',
    int indexPosition = 1,
    String keyType = '',
    int limit = 10,
    bool reverse = false,
  }) async {
    dynamic result = await this._post('/chain/get_table_rows', {
      'json': json,
      'code': code,
      'scope': scope,
      'table': table,
      'table_key': tableKey,
      'lower_bound': lower,
      'upper_bound': upper,
      'index_position': indexPosition,
      'key_type': keyType,
      'limit': limit,
      'reverse': reverse,
    });
    return result;
  }

  Future<List<Map<String, dynamic>>> getTableRows1(
    String code,
    String scope,
    String table, {
    bool json = true,
    String tableKey = '',
    String lower = '',
    String upper = '',
    int indexPosition = 1,
    String keyType = '',
    int limit = 10,
    bool reverse = false,
  }) async {
    dynamic result = await this._post('/chain/get_table_rows', {
      'json': json,
      'code': code,
      'scope': scope,
      'table': table,
      'table_key': tableKey,
      'lower_bound': lower,
      'upper_bound': upper,
      'index_position': indexPosition,
      'key_type': keyType,
      'limit': limit,
      'reverse': reverse,
    });
    if (result is Map) {
      //  print('lower' + lower.toString());
      List<Map<String, dynamic>> cast =
          result['rows'].cast<Map<String, dynamic>>();
      cast.insert(0, {'next_key': result['next_key']});
      //   print('lower' + cast.length.toString());
      return cast;
    }
    return [];
  }

  /// Get table row (FLON get table ...)
  Future<Map<String, dynamic>?> getTableRow(
    String code,
    String scope,
    String table, {
    bool json = true,
    String tableKey = '',
    String lower = '',
    String upper = '',
    int indexPosition = 1,
    String keyType = '',
    bool reverse = false,
  }) async {
    var rows = await getTableRows(
      code,
      scope,
      table,
      json: json,
      tableKey: tableKey,
      lower: lower,
      upper: upper,
      indexPosition: indexPosition,
      keyType: keyType,
      limit: 1,
      reverse: reverse,
    );

    return rows.length > 0 ? rows[0] : null;
  }

  /// Get FLON Block Info
  Future<Block> getBlock(String blockNumOrId) async {
    return this._post(
        '/chain/get_block', {'block_num_or_id': blockNumOrId}).then((block) {
      return Block.fromJson(block);
    }).catchError((error, stackTrace) {
      return Block('', null);
    });
  }

  /// Get FLON Block Header State
  Future<BlockHeaderState> getBlockHeaderState(String blockNumOrId) async {
    return this._post('/chain/get_block_header_state',
        {'block_num_or_id': blockNumOrId}).then((block) {
      return BlockHeaderState.fromJson(block);
    });
  }

  /// Get FLON abi from account name
  Future<AbiResp> getAbi(String accountName) async {
    return this
        ._post('/chain/get_abi', {'account_name': accountName}).then((abi) {
      return AbiResp.fromJson(abi);
    });
  }

  /// Get FLON raw abi from account name
  Future<AbiResp> getRawAbi(String accountName) async {
    return this
        ._post('/chain/get_raw_abi', {'account_name': accountName}).then((abi) {
      return AbiResp.fromJson(abi);
    });
  }

  /// Get FLON raw code and abi from account name
  Future<AbiResp> getRawCodeAndAbi(String accountName) async {
    return this._post('/chain/get_raw_code_and_abi',
        {'account_name': accountName}).then((abi) {
      return AbiResp.fromJson(abi);
    });
  }

  /// Get FLON account info form the given account name
  Future<Account> getAccount(String accountName, {String? path}) async {
    return this._post(path ?? '/chain/get_account',
        {'account_name': accountName}).then((account) {
      return Account.fromJson(account);
    });
  }

  /// Get FLON account info form the given account name
  Future<List<Holding>> getCurrencyBalance(
      String code, String account, String symbol,
      {int decimal = 0}) async {
    return this._post('/chain/get_currency_balance',
        {'code': code, 'account': account, 'symbol': symbol}).then((balance) {
      var list = balance as List;
      if (list.isEmpty && decimal != 0) {
        list.add('${NumUtil.getNumByValueDouble(0.0, decimal)} $symbol');
      }
      return (list).map((e) => new Holding.fromJson(e)).toList();
    });
  }

  /// Get FLON account currency stats
  Future<CurrencyStats> getCurrencyStats(String code, String symbol) async {
    return this._post('/chain/get_currency_stats',
        {'code': code, 'symbol': symbol}).then((data) {
      return CurrencyStats.fromJson(data[symbol]);
    });
  }

  /// Get required key by transaction from FLON blockchain
  Future<RequiredKeys> getRequiredKeys(
      Transaction transaction, List<String> availableKeys) async {
    transaction = await _serializeActions(transaction);

    // raw abi to json
//      AbiResp abiResp = await getRawAbi(account);
//    print(abiResp.abi);
    return this._post('/chain/get_required_keys', {
      'transaction': transaction,
      'available_keys': availableKeys
    }).then((requiredKeys) {
      return RequiredKeys.fromJson(requiredKeys);
    });
  }

  /// Get FLON account actions
  Future<Actions> getActions(String accountName,
      {int pos = -1, int offset = -1}) async {
    return this._post('/history/get_actions', {
      'account_name': accountName,
      'pot': pos,
      'offset': offset
    }).then((actions) {
      return Actions.fromJson(actions);
    });
  }

  /// Get FLON transaction
  Future<TransactionBlock> getTransaction(String id,
      {int? blockNumHint}) async {
    return this._post('/history/get_transaction',
        {'id': id, 'block_num_hint': blockNumHint}).then((transaction) {
      return TransactionBlock.fromJson(transaction);
    });
  }

  /// Get Key Accounts
  Future<AccountNames> getKeyAccounts1(String pubKey) async {
    return this._post('/chain/get_accounts_by_authorizers', {
      'keys': [pubKey]
    }).then((accountsData) {
      List list = accountsData['accounts'] as List;
      AccountNames accountNames = AccountNames();
      accountNames.accountNames = [];
      if (list.isNotEmpty) {
        accountNames.accountNames = [];
        list.forEach((accountData) {
          if (!accountNames.accountNames!
              .contains(accountData['account_name'])) {
            accountNames.accountNames!.add(accountData['account_name']);
          }
        });
      }
      return accountNames;
    });
  }

  /// Get Key Accounts
  Future<dynamic> getKeyAccounts3(
    List pubKey,
    List accounts,
  ) async {
    return this._post('/chain/get_accounts_by_authorizers',
        {'keys': pubKey, 'accounts': accounts}).then((accountsData) {
      return accountsData;
    });
  }

  /// Get Key Accounts
  Future<AccountNames> getKeyAccounts2(String pubKey) async {
    return this._post('/history/get_key_accounts', {'public_key': pubKey}).then(
        (accountNames) {
      return AccountNames.fromJson(accountNames);
    });
  }

  /// Get Key Accounts
  Future<AccountNames> getKeyAccounts(String pubKey) async {
    //  if (chainId == mainChainId) {
    return getKeyAccounts1(pubKey);
    // } else {
    //   return getKeyAccounts2(pubKey);
    // }
  }

  /// Get FLON Block Info
  Future<Block> getMBlock(int blocksBehind) async {
    int retryCount = 0;
    bool getMBlock = true;
    Block refBlock = Block('', null);
    while (getMBlock) {
      retryCount++;
      NodeInfo info = await this.getInfo();
      refBlock = await getBlock((info.headBlockNum! - blocksBehind).toString());
      if (refBlock.blockNum != null) {
        getMBlock = false;
        break;
      }
      if (retryCount == 3) {
        getMBlock = false;
        break;
      }
    }
    return refBlock;
  }

  /// Push transaction to FLON chain
  Future<dynamic> pushTransaction(Transaction transaction,
      {int blocksBehind = 3,
      int expireSecond = 180,
      required String privateKey,
      int httpTimeout = 40,
      Function? getCodeWalletSignString}) async {
    List<String> signatures = [];
    Block refBlock = await getMBlock(blocksBehind);
    if (refBlock.blockNum == null) {
      throw Exception('NetChooseSettingPage_net_error'.tr);
    }
    transaction = await _fullFill(
        transaction, refBlock, privateKey.isEmpty ? 300 : expireSecond);
    if (chainId == null) {
      await this.getInfo();
    }
    transaction = await _serializeActions(transaction);
    Uint8List serializedTrx =
        transaction.toBinary(transactionTypes['transaction']!);
    Uint8List signBuf =
        Uint8List.fromList(List.from(ser.stringToHex(currentChainId))
          ..addAll(serializedTrx)
          ..addAll(Uint8List(32)));
    if (privateKey.isEmpty) {
      String signString = await getCodeWalletSignString!
          .call("3_" + currentChainId + "_" + arrayToHex(serializedTrx));
      signatures.add(signString);
    } else {
      ecc.FLONPrivateKey pKey = ecc.FLONPrivateKey.fromString(privateKey);
      signatures.add(pKey.sign(signBuf).toString());
    }
    return this
        ._post(
            '/chain/push_transaction',
            {
              'signatures': signatures,
              'compression': 0,
              'packed_context_free_data': '',
              'packed_trx': ser.arrayToHex(serializedTrx),
            },
            httpTimeout: httpTimeout)
        .then((processedTrx) {
      transaction.signatures = signatures;
      return processedTrx;
    });
  }

  Future<dynamic> postTransaction(
    List<String> signatures,
    Uint8List serializedTrx, {
    int httpTimeout = 40,
  }) {
    return this
        ._post(
            '/chain/push_transaction',
            {
              'signatures': signatures,
              'compression': 0,
              'packed_context_free_data': '',
              'packed_trx': ser.arrayToHex(serializedTrx),
            },
            httpTimeout: httpTimeout)
        .then((processedTrx) {
      return processedTrx;
    });
  }

  /// Push transaction to FLON chain
  Future<PushTransactionArgs> signTransaction(
    Transaction transaction, {
    required String privateKey,
    Function? getCodeWalletSignString,
  }) async {
    List<String> signatures = [];

    if (chainId == null) {
      await this.getInfo();
    }
    transaction = await _serializeActions(transaction);
    Uint8List serializedTrx =
        transaction.toBinary(transactionTypes['transaction']!);
    Uint8List signBuf =
        Uint8List.fromList(List.from(ser.stringToHex(currentChainId))
          ..addAll(serializedTrx)
          ..addAll(Uint8List(32)));
    if (privateKey.isEmpty) {
      String signString = await getCodeWalletSignString!
          .call("3_" + currentChainId + "_" + arrayToHex(serializedTrx));
      signatures.add(signString);
    } else {
      ecc.FLONPrivateKey pKey = ecc.FLONPrivateKey.fromString(privateKey);
      signatures.add(pKey.sign(signBuf).toString());
    }

    return PushTransactionArgs(signatures, serializedTrx, transaction.toJson());
  }

  ///  order pay     Push transaction to FLON chain
  Future<PushTransactionArgs> orderPaySignTransaction(
    Transaction transaction, {
    required String privateKey,
    Function? getCodeWalletSignString,
    int blocksBehind = 3,
    int expireSecond = 180,
  }) async {
    List<String> signatures = [];
    Block refBlock = await getMBlock(blocksBehind);
    if (refBlock.blockNum == null) {
      throw Exception('NetChooseSettingPage_net_error'.tr);
    }
    transaction = await _fullFill(
        transaction, refBlock, privateKey.isEmpty ? 300 : expireSecond);
    if (chainId == null) {
      await this.getInfo();
    }
    transaction = await _serializeActions(transaction);
    Uint8List serializedTrx =
        transaction.toBinary(transactionTypes['transaction']!);
    Uint8List signBuf =
        Uint8List.fromList(List.from(ser.stringToHex(currentChainId))
          ..addAll(serializedTrx)
          ..addAll(Uint8List(32)));
    if (privateKey.isEmpty) {
      String signString = await getCodeWalletSignString!
          .call("3_" + currentChainId + "_" + arrayToHex(serializedTrx));
      signatures.add(signString);
    } else {
      ecc.FLONPrivateKey pKey = ecc.FLONPrivateKey.fromString(privateKey);
      signatures.add(pKey.sign(signBuf).toString());
    }

    return PushTransactionArgs(signatures, serializedTrx, transaction.toJson());
  }

  /// Get data needed to serialize actions in a contract */
  Future<Contract> _getContract(String accountName) async {
    var abi = await getRawAbi(accountName);
    var types = ser.getTypesFromAbi(ser.createInitialTypes(), abi.abi!);
    var actions = new Map<String, Type>();
    for (var act in abi.abi!.actions!) {
      actions[act.name] = ser.getType(types, act.type);
    }
    var result = Contract(types, actions);
    return result;
  }

  /// Fill the transaction withe reference block data
  Future<Transaction> _fullFill(
      Transaction transaction, Block refBlock, int expireSecond) async {
    transaction.expiration =
        refBlock.timestamp!.add(Duration(seconds: expireSecond));
    transaction.refBlockNum = refBlock.blockNum! & 0xffff;
    transaction.refBlockPrefix = refBlock.refBlockPrefix;

    return transaction;
  }

  /// serialize actions in a transaction
  Future<Transaction> _serializeActions(Transaction transaction) async {
    for (Action action in transaction.actions!) {
      if (action.data is Map) {
        String account = action.account!;
        Contract contract = await _getContract(account);
        action.data =
            _serializeActionData(contract, account, action.name!, action.data!);
      }
    }
    return transaction;
  }

  /// Convert action data to serialized form (hex) */
  String _serializeActionData(
      Contract contract, String account, String name, Object data) {
    var action = contract.actions[name];
    if (action == null) {
      throw "Unknown action $name in contract $account";
    }
    var buffer = new ser.SerialBuffer(Uint8List(0));
    action.serialize?.call(action, buffer, data);
    return ser.arrayToHex(buffer.asUint8List());
  }

//  Future<List<AbiResp>> _getTransactionAbis(Transaction transaction) async {
//    Set<String> accounts = Set();
//    List<AbiResp> result = [];
//
//    for (Action action in transaction.actions) {
//      accounts.add(action.account);
//    }
//
//    for (String accountName in accounts) {
//      result.add(await this.getRawAbi(accountName));
//    }
//  }

  Future<PushTransactionArgs> _pushTransactionArgs(
      String chainId,
      Type transactionType,
      Transaction transaction,
      bool sign,
      List<String>? privateKeys,
      {bool needGetRequiredKeys = false}) async {
    List<String> signatures = [];
    Map<String, ecc.FLONPrivateKey> keys = Map();
    if (sign) {
      if (privateKeys == null) {
        throw "privateKeys can not be null";
      }
      _mapKeys(keys, privateKeys);
    }
    RequiredKeys? requiredKeys;
    if (needGetRequiredKeys) {
      requiredKeys = await getRequiredKeys(transaction, keys.keys.toList());
    } else {
      transaction = await _serializeActions(transaction);
    }
    Uint8List serializedTrx = transaction.toBinary(transactionType);
    if (sign) {
      Uint8List signBuf = Uint8List.fromList(List.from(ser.stringToHex(chainId))
        ..addAll(serializedTrx)
        ..addAll(Uint8List(32)));
      if (requiredKeys != null) {
        for (String publicKey in requiredKeys.requiredKeys!) {
          ecc.FLONPrivateKey pKey = keys[publicKey]!;
          signatures.add(pKey.sign(signBuf).toString());
        }
      } else {
        for (String publicKey in keys.keys) {
          ecc.FLONPrivateKey pKey = keys[publicKey]!;
          signatures.add(pKey.sign(signBuf).toString());
        }
      }
    }

    return PushTransactionArgs(signatures, serializedTrx, transaction.toJson());
  }

  /// serialize actions in a transaction
  Future<Transaction?> serializeTransaction(Transaction transaction,
      {int deadTime = 0}) async {
    Block refBlock = await getMBlock(3);
    if (refBlock.blockNum == null) {
      return null;
    }
    transaction.expiration =
        refBlock.timestamp!.add(Duration(seconds: deadTime));
    transaction.refBlockNum = refBlock.blockNum! & 0xffff;
    transaction.refBlockPrefix = refBlock.refBlockPrefix;
    transaction = await _serializeActions(transaction);
    return transaction;
  }
}

class PushTransactionArgs {
  List<String> signatures;
  Uint8List serializedTransaction;
  Map<String, dynamic> transactionJson;

  PushTransactionArgs(
    this.signatures,
    this.serializedTransaction,
    this.transactionJson,
  );
}

nameToNumeric(String accountName) {
  var buffer = SerialBuffer(Uint8List(0));

  buffer.pushName(accountName);

  return binaryToDecimal(buffer.getUint8List(8));
}
