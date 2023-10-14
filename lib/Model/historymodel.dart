import 'dart:convert';

class HistoryModel {
  final String history_id;
  final String history_date;
  final String supply_id;
  final String money_source_id;
  final String supply_name;
  final String account_id;
  final String amount;
  final String short_name;
  HistoryModel({
    required this.history_id,
    required this.history_date,
    required this.supply_id,
    required this.money_source_id,
    required this.supply_name,
    required this.account_id,
    required this.amount,
    required this.short_name,
  });

  HistoryModel copyWith({
    String? history_id,
    String? history_date,
    String? supply_id,
    String? money_source_id,
    String? supply_name,
    String? account_id,
    String? amount,
    String? short_name,
  }) {
    return HistoryModel(
      history_id: history_id ?? this.history_id,
      history_date: history_date ?? this.history_date,
      supply_id: supply_id ?? this.supply_id,
      money_source_id: money_source_id ?? this.money_source_id,
      supply_name: supply_name ?? this.supply_name,
      account_id: account_id ?? this.account_id,
      amount: amount ?? this.amount,
      short_name: short_name ?? this.short_name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'history_id': history_id});
    result.addAll({'history_date': history_date});
    result.addAll({'supply_id': supply_id});
    result.addAll({'money_source_id': money_source_id});
    result.addAll({'supply_name': supply_name});
    result.addAll({'account_id': account_id});
    result.addAll({'amount': amount});
    result.addAll({'short_name': short_name});

    return result;
  }

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      history_id: map['history_id'] ?? '',
      history_date: map['history_date'] ?? '',
      supply_id: map['supply_id'] ?? '',
      money_source_id: map['money_source_id'] ?? '',
      supply_name: map['supply_name'] ?? '',
      account_id: map['account_id'] ?? '',
      amount: map['amount'] ?? '',
      short_name: map['short_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryModel.fromJson(String source) =>
      HistoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HistoryModel(history_id: $history_id, history_date: $history_date, supply_id: $supply_id, money_source_id: $money_source_id, supply_name: $supply_name, account_id: $account_id, amount: $amount, short_name: $short_name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryModel &&
        other.history_id == history_id &&
        other.history_date == history_date &&
        other.supply_id == supply_id &&
        other.money_source_id == money_source_id &&
        other.supply_name == supply_name &&
        other.account_id == account_id &&
        other.amount == amount &&
        other.short_name == short_name;
  }

  @override
  int get hashCode {
    return history_id.hashCode ^
        history_date.hashCode ^
        supply_id.hashCode ^
        money_source_id.hashCode ^
        supply_name.hashCode ^
        account_id.hashCode ^
        amount.hashCode ^
        short_name.hashCode;
  }
}
