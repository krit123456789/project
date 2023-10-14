import 'dart:convert';

class MoneySourceModel {
  final String supply_id;
  final String money_source_id;
  final String amount;
  final String restock_date;
  final String created_at;
  final String updated_at;
  MoneySourceModel({
    required this.supply_id,
    required this.money_source_id,
    required this.amount,
    required this.restock_date,
    required this.created_at,
    required this.updated_at,
  });

  MoneySourceModel copyWith({
    String? supply_id,
    String? money_source_id,
    String? amount,
    String? restock_date,
    String? created_at,
    String? updated_at,
  }) {
    return MoneySourceModel(
      supply_id: supply_id ?? this.supply_id,
      money_source_id: money_source_id ?? this.money_source_id,
      amount: amount ?? this.amount,
      restock_date: restock_date ?? this.restock_date,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'supply_id': supply_id});
    result.addAll({'money_source_id': money_source_id});
    result.addAll({'amount': amount});
    result.addAll({'restock_date': restock_date});
    result.addAll({'created_at': created_at});
    result.addAll({'updated_at': updated_at});

    return result;
  }

  factory MoneySourceModel.fromMap(Map<String, dynamic> map) {
    return MoneySourceModel(
      supply_id: map['supply_id'] ?? '',
      money_source_id: map['money_source_id'] ?? '',
      amount: map['amount'] ?? '',
      restock_date: map['restock_date'] ?? '',
      created_at: map['created_at'] ?? '',
      updated_at: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MoneySourceModel.fromJson(String source) =>
      MoneySourceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MoneySourceModel(supply_id: $supply_id, money_source_id: $money_source_id, amount: $amount, restock_date: $restock_date, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MoneySourceModel &&
        other.supply_id == supply_id &&
        other.money_source_id == money_source_id &&
        other.amount == amount &&
        other.restock_date == restock_date &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return supply_id.hashCode ^
        money_source_id.hashCode ^
        amount.hashCode ^
        restock_date.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
