import 'package:json_annotation/json_annotation.dart';

import '../../flondart.dart';
import './conversion_helper.dart';

part 'account.g.dart';

/// Represents FLON account information
@JsonSerializable()
class Account with ConversionHelper {
  @JsonKey(name: 'account_name')
  final String accountName;

  @JsonKey(name: 'head_block_num')
  final int headBlockNum;

  @JsonKey(name: 'head_block_time')
  DateTime? headBlockTime;

  @JsonKey(name: 'privileged')
  bool? privileged;

  @JsonKey(name: 'last_code_update')
  DateTime? lastCodeUpdate;

  @JsonKey(name: 'created')
  DateTime? created;

  @JsonKey(name: 'creator')
  String? creator;

  @JsonKey(name: 'core_liquid_balance')
  Holding? coreLiquidBalance;

  @JsonKey(name: 'is_res_unlimited')
  bool? is_res_unlimited;

  @JsonKey(name: 'gas_reserved')
  int? gas_reserved;

  @JsonKey(name: 'gas_max')
  BigInt? gas_max;

  @JsonKey(name: 'net_res')
  NetResources? netReources;

  @JsonKey(name: 'cpu_res')
  CpuResources? cpuReources;

  @JsonKey(name: 'ram_res')
  RamResources? ramReources;

  @JsonKey(name: 'permissions')
  List<Permission>? permissions;

  @JsonKey(name: 'refund_request')
  RefundRequest? refundRequest;

  @JsonKey(name: 'voter_info')
  VoterInfo? voterInfo;

  @JsonKey(name: 'subjective_cpu_bill')
  int? subjectiveCpuBill;

  @JsonKey(name: 'eosio_any_linked_actions')
  List<Action>? eosioAnyLinkedActions;

  Account(this.accountName, this.headBlockNum);

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  @override
  String toString() => this.toJson().toString();
}

// this is not using json serializer as it is customized serializer to
// convert the amount currency split by space
/// Structure for the JSON string format e.g. '1.0000 FLON', it splits that by
/// 'amount' and 'currency'
class Holding {
  double? amount;
  String? currency;
  String? amountStr;
  Holding.fromJson(String json) {
    List<String> segments = json.split(" ");
    if (segments.length != 2) {
      return;
    }
    amountStr = segments[0];
    this.amount = double.parse(segments[0]);
    this.currency = segments[1];
  }

  String toJson() => '${amount} ${currency}';

  @override
  String toString() => this.toJson().toString();
}

@JsonSerializable()
class Permission {
  @JsonKey(name: 'perm_name')
  String? permName;

  @JsonKey(name: 'parent')
  String? parent;

  @JsonKey(name: 'required_auth')
  RequiredAuth? requiredAuth;

  Permission();

  factory Permission.fromJson(Map<String, dynamic> json) =>
      _$PermissionFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionToJson(this);

  @override
  String toString() => this.toJson().toString();
}

@JsonSerializable()
class RequiredAuth {
  @JsonKey(name: 'threshold')
  int? threshold;

  @JsonKey(name: 'keys')
  List<AuthKey>? keys;

  @JsonKey(name: 'accounts')
  List<Object>? accounts;

  @JsonKey(name: 'waits')
  List<Object>? waits;

  RequiredAuth();

  factory RequiredAuth.fromJson(Map<String, dynamic> json) =>
      _$RequiredAuthFromJson(json);

  Map<String, dynamic> toJson() => _$RequiredAuthToJson(this);

  @override
  String toString() => this.toJson().toString();
}

@JsonSerializable()
class AuthKey {
  @JsonKey(name: 'key')
  String? key;

  @JsonKey(name: 'weight')
  int? weight;

  AuthKey();

  factory AuthKey.fromJson(Map<String, dynamic> json) =>
      _$AuthKeyFromJson(json);

  Map<String, dynamic> toJson() => _$AuthKeyToJson(this);

  @override
  String toString() => this.toJson().toString();
}

@JsonSerializable()
class NetResources with ConversionHelper {
  @JsonKey(name: 'used')
  int? used;

  @JsonKey(name: 'max')
  BigInt? max;

  NetResources();

  factory NetResources.fromJson(Map<String, dynamic> json) =>
      _$NetResourcesFromJson(json);

  Map<String, dynamic> toJson() => _$NetResourcesToJson(this);

  @override
  String toString() => this.toJson().toString();
}

@JsonSerializable()
class CpuResources with ConversionHelper {
  @JsonKey(name: 'used')
  int? used;

  @JsonKey(name: 'max')
  BigInt? max;

  CpuResources();

  factory CpuResources.fromJson(Map<String, dynamic> json) =>
      _$CpuResourcesFromJson(json);

  Map<String, dynamic> toJson() => _$CpuResourcesToJson(this);

  @override
  String toString() => this.toJson().toString();
}

@JsonSerializable()
class RamResources with ConversionHelper {
  @JsonKey(name: 'used')
  int? used;

  @JsonKey(name: 'max')
  BigInt? max;

  RamResources();

  factory RamResources.fromJson(Map<String, dynamic> json) =>
      _$RamResourcesFromJson(json);

  Map<String, dynamic> toJson() => _$RamResourcesToJson(this);

  @override
  String toString() => this.toJson().toString();
}

@JsonSerializable()
class RefundRequest {
  @JsonKey(name: 'owner')
  String? owner;

  @JsonKey(name: 'request_time')
  DateTime? requestTime;

  @JsonKey(name: 'net_amount')
  Holding? netAmount;

  @JsonKey(name: 'cpu_amount')
  Holding? cpuAmount;

  RefundRequest();

  factory RefundRequest.fromJson(Map<String, dynamic> json) =>
      _$RefundRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefundRequestToJson(this);

  @override
  String toString() => this.toJson().toString();
}

@JsonSerializable()
class VoterInfo with ConversionHelper {
  @JsonKey(name: 'owner')
  String? owner;

  @JsonKey(name: 'proxy')
  String? proxy;

  @JsonKey(name: 'producers')
  Object? producers;

  @JsonKey(name: 'staked', fromJson: ConversionHelper.getIntFromJson)
  int? staked;

  @JsonKey(name: 'last_vote_weight')
  String? lastVoteWeight;

  @JsonKey(name: 'proxied_vote_weight')
  String? proxiedVoteWeight;

  @JsonKey(name: 'is_proxy')
  int? isProxy;

  VoterInfo();

  factory VoterInfo.fromJson(Map<String, dynamic> json) =>
      _$VoterInfoFromJson(json);

  Map<String, dynamic> toJson() => _$VoterInfoToJson(this);

  @override
  String toString() => this.toJson().toString();
}
