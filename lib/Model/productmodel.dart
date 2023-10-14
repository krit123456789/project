import 'dart:convert';

class ProductModel {
  final String supply_id;
  final String supply_name;
  final String category_id;
  final String supply_picture;
  final String created_at;
  final String updated_at;
  ProductModel({
    required this.supply_id,
    required this.supply_name,
    required this.category_id,
    required this.supply_picture,
    required this.created_at,
    required this.updated_at,
  });

  ProductModel copyWith({
    String? supply_id,
    String? supply_name,
    String? category_id,
    String? supply_picture,
    String? created_at,
    String? updated_at,
  }) {
    return ProductModel(
      supply_id: supply_id ?? this.supply_id,
      supply_name: supply_name ?? this.supply_name,
      category_id: category_id ?? this.category_id,
      supply_picture: supply_picture ?? this.supply_picture,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'supply_id': supply_id});
    result.addAll({'supply_name': supply_name});
    result.addAll({'category_id': category_id});
    result.addAll({'supply_picture': supply_picture});
    result.addAll({'created_at': created_at});
    result.addAll({'updated_at': updated_at});

    return result;
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      supply_id: map['supply_id'] ?? '',
      supply_name: map['supply_name'] ?? '',
      category_id: map['category_id'] ?? '',
      supply_picture: map['supply_picture'] ?? '',
      created_at: map['created_at'] ?? '',
      updated_at: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(supply_id: $supply_id, supply_name: $supply_name, category_id: $category_id, supply_picture: $supply_picture, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.supply_id == supply_id &&
        other.supply_name == supply_name &&
        other.category_id == category_id &&
        other.supply_picture == supply_picture &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return supply_id.hashCode ^
        supply_name.hashCode ^
        category_id.hashCode ^
        supply_picture.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
