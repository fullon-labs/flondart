// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'account.dart';

/// currency status
class CurrencyStats {
  Holding supply;

  Holding maxSupply;

  String issuer;
  CurrencyStats({
    required this.supply,
    required this.maxSupply,
    required this.issuer,
  });

  CurrencyStats copyWith({
    Holding? supply,
    Holding? maxSupply,
    String? issuer,
  }) {
    return CurrencyStats(
      supply: supply ?? this.supply,
      maxSupply: maxSupply ?? this.maxSupply,
      issuer: issuer ?? this.issuer,
    );
  }

  factory CurrencyStats.fromJson(Map<String, dynamic> json) => CurrencyStats(
        issuer: json['issuer'],
        maxSupply: Holding.fromJson(json['max_supply']),
        supply: Holding.fromJson(json['supply']),
      );

  Map<String, dynamic> toJson() => {
        "issuer": issuer,
        "max_supply": maxSupply.toJson(),
        "supply": supply.toJson(),
      };

  @override
  bool operator ==(covariant CurrencyStats other) {
    if (identical(this, other)) return true;

    return other.supply == supply &&
        other.maxSupply == maxSupply &&
        other.issuer == issuer;
  }

  @override
  int get hashCode => supply.hashCode ^ maxSupply.hashCode ^ issuer.hashCode;

  @override
  String toString() =>
      'CurrencyStats(supply: $supply, maxSupply: $maxSupply, issuer: $issuer)';
}
