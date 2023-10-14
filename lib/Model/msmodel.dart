import 'dart:convert';

class MsModel {
  final String money_source_id;
  final String money_source_name;
  final String money_source_image;
  final String created_at;
  final String updated_at;
  MsModel({
    required this.money_source_id,
    required this.money_source_name,
    required this.money_source_image,
    required this.created_at,
    required this.updated_at,
  });

  MsModel copyWith({
    String? money_source_id,
    String? money_source_name,
    String? money_source_image,
    String? created_at,
    String? updated_at,
  }) {
    return MsModel(
      money_source_id: money_source_id ?? this.money_source_id,
      money_source_name: money_source_name ?? this.money_source_name,
      money_source_image: money_source_image ?? this.money_source_image,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'money_source_id': money_source_id});
    result.addAll({'money_source_name': money_source_name});
    result.addAll({'money_source_image': money_source_image});
    result.addAll({'created_at': created_at});
    result.addAll({'updated_at': updated_at});

    return result;
  }

  factory MsModel.fromMap(Map<String, dynamic> map) {
    return MsModel(
      money_source_id: map['money_source_id'] ?? '',
      money_source_name: map['money_source_name'] ?? '',
      money_source_image: map['money_source_image'] ?? '',
      created_at: map['created_at'] ?? '',
      updated_at: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MsModel.fromJson(String source) =>
      MsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MsModel(money_source_id: $money_source_id, money_source_name: $money_source_name, money_source_image: $money_source_image, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MsModel &&
        other.money_source_id == money_source_id &&
        other.money_source_name == money_source_name &&
        other.money_source_image == money_source_image &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return money_source_id.hashCode ^
        money_source_name.hashCode ^
        money_source_image.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
