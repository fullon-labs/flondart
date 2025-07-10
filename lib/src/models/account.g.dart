// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      json['account_name'] as String,
      json['head_block_num'] as int,
    )
      ..headBlockTime = json['head_block_time'] == null
          ? null
          : DateTime.parse(json['head_block_time'] as String)
      ..privileged = json['privileged'] as bool?
      ..lastCodeUpdate = json['last_code_update'] == null
          ? null
          : DateTime.parse(json['last_code_update'] as String)
      ..created = json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String)
      ..creator = json['creator'] as String?
      ..coreLiquidBalance = json['core_liquid_balance'] == null
          ? null
          : Holding.fromJson(json['core_liquid_balance'] as String)
      ..is_res_unlimited = json['is_res_unlimited'] as bool? ?? false
      ..gas_reserved = ConversionHelper.getIntFromJson(json['gas_reserved'])
      ..gas_max = BigInt.parse(json['gas_max'] as String)
      ..netReources = json['net_res'] == null
          ? null
          : NetResources.fromJson(json['net_res'] as Map<String, dynamic>)
      ..cpuReources = json['cpu_res'] == null
          ? null
          : CpuResources.fromJson(json['cpu_res'] as Map<String, dynamic>)
      ..ramReources = json['ram_res'] == null
          ? null
          : RamResources.fromJson(json['ram_res'] as Map<String, dynamic>)
      ..permissions = (json['permissions'] as List<dynamic>?)
          ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
          .toList()
      ..refundRequest = json['refund_request'] == null
          ? null
          : RefundRequest.fromJson(
              json['refund_request'] as Map<String, dynamic>)
      ..voterInfo = json['voter_info'] == null
          ? null
          : VoterInfo.fromJson(json['voter_info'] as Map<String, dynamic>)
      ..subjectiveCpuBill = json['subjective_cpu_bill'] as int? ?? 0
      ..eosioAnyLinkedActions =
          (json['eosio_any_linked_actions'] as List<dynamic>?)
              ?.map((e) => Action.fromJson(e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'account_name': instance.accountName,
      'head_block_num': instance.headBlockNum,
      'head_block_time': instance.headBlockTime?.toIso8601String(),
      'privileged': instance.privileged,
      'last_code_update': instance.lastCodeUpdate?.toIso8601String(),
      'created': instance.created?.toIso8601String(),
      'creator': instance.creator,
      'core_liquid_balance': instance.coreLiquidBalance,
      'is_res_unlimited': instance.is_res_unlimited,
      'gas_reserved': instance.gas_reserved,
      'gas_max': instance.gas_max,
      'net_res': instance.netReources,
      'cpu_res': instance.cpuReources,
      'ram_res': instance.ramReources,
      'permissions': instance.permissions,
      'refund_request': instance.refundRequest,
      'voter_info': instance.voterInfo,
      'subjective_cpu_bill': instance.subjectiveCpuBill,
      'eosio_any_linked_actions': instance.eosioAnyLinkedActions,
    };

// Limit _$LimitFromJson(Map<String, dynamic> json) => Limit()
//   ..used = ConversionHelper.getIntFromJson(json['used'])
//   ..available = ConversionHelper.getIntFromJson(json['available'])
//   ..max = ConversionHelper.getIntFromJson(json['max']);

// Map<String, dynamic> _$LimitToJson(Limit instance) => <String, dynamic>{
//       'used': instance.used,
//       'available': instance.available,
//       'max': instance.max,
//     };

Permission _$PermissionFromJson(Map<String, dynamic> json) => Permission()
  ..permName = json['perm_name'] as String?
  ..parent = json['parent'] as String?
  ..requiredAuth = json['required_auth'] == null
      ? null
      : RequiredAuth.fromJson(json['required_auth'] as Map<String, dynamic>);

Map<String, dynamic> _$PermissionToJson(Permission instance) =>
    <String, dynamic>{
      'perm_name': instance.permName,
      'parent': instance.parent,
      'required_auth': instance.requiredAuth,
    };

RequiredAuth _$RequiredAuthFromJson(Map<String, dynamic> json) => RequiredAuth()
  ..threshold = json['threshold'] as int?
  ..keys = (json['keys'] as List<dynamic>?)
      ?.map((e) => AuthKey.fromJson(e as Map<String, dynamic>))
      .toList()
  ..accounts =
      (json['accounts'] as List<dynamic>?)?.map((e) => e as Object).toList()
  ..waits = (json['waits'] as List<dynamic>?)?.map((e) => e as Object).toList();

Map<String, dynamic> _$RequiredAuthToJson(RequiredAuth instance) =>
    <String, dynamic>{
      'threshold': instance.threshold,
      'keys': instance.keys,
      'accounts': instance.accounts,
      'waits': instance.waits,
    };

AuthKey _$AuthKeyFromJson(Map<String, dynamic> json) => AuthKey()
  ..key = json['key'] as String?
  ..weight = json['weight'] as int?;

Map<String, dynamic> _$AuthKeyToJson(AuthKey instance) => <String, dynamic>{
      'key': instance.key,
      'weight': instance.weight,
    };

//<-- NET Resources --->
NetResources _$NetResourcesFromJson(Map<String, dynamic> json) => NetResources()
  ..used = json['used'] as int
  ..max = json['max'] as String?;

Map<String, dynamic> _$NetResourcesToJson(NetResources instance) =>
    <String, dynamic>{'used': instance.used, 'max': instance.max};

//<-- CPU Resources --->
CpuResources _$CpuResourcesFromJson(Map<String, dynamic> json) => CpuResources()
  ..used = json['used'] as int
  ..max = json['max'] as String?;

Map<String, dynamic> _$CpuResourcesToJson(CpuResources instance) =>
    <String, dynamic>{'used': instance.used, 'max': instance.max};

//<-- RAM Resources --->
RamResources _$RamResourcesFromJson(Map<String, dynamic> json) => RamResources()
  ..used = json['used'] as int
  ..max = json['max'] as String?;

Map<String, dynamic> _$RamResourcesToJson(RamResources instance) =>
    <String, dynamic>{'used': instance.used, 'max': instance.max};

//<-- refund_request --->
RefundRequest _$RefundRequestFromJson(Map<String, dynamic> json) =>
    RefundRequest()
      ..owner = json['owner'] as String?
      ..requestTime = json['request_time'] == null
          ? null
          : DateTime.parse(json['request_time'] as String)
      ..netAmount = json['net_amount'] == null
          ? null
          : Holding.fromJson(json['net_amount'] as String)
      ..cpuAmount = json['cpu_amount'] == null
          ? null
          : Holding.fromJson(json['cpu_amount'] as String);

Map<String, dynamic> _$RefundRequestToJson(RefundRequest instance) =>
    <String, dynamic>{
      'owner': instance.owner,
      'request_time': instance.requestTime?.toIso8601String(),
      'net_amount': instance.netAmount,
      'cpu_amount': instance.cpuAmount,
    };

//<-- vote_info --->
VoterInfo _$VoterInfoFromJson(Map<String, dynamic> json) => VoterInfo()
  ..owner = json['owner'] as String?
  ..proxy = json['proxy'] as String?
  ..producers = json['producers']
  ..staked = ConversionHelper.getIntFromJson(json['staked'])
  ..lastVoteWeight = json['last_vote_weight'] as String?
  ..proxiedVoteWeight = json['proxied_vote_weight'] as String?
  ..isProxy = json['is_proxy'] as int?;

Map<String, dynamic> _$VoterInfoToJson(VoterInfo instance) => <String, dynamic>{
      'owner': instance.owner,
      'proxy': instance.proxy,
      'producers': instance.producers,
      'staked': instance.staked,
      'last_vote_weight': instance.lastVoteWeight,
      'proxied_vote_weight': instance.proxiedVoteWeight,
      'is_proxy': instance.isProxy,
    };
