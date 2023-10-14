import 'dart:convert';

class CategoryModel {
  final String category_id;
  final String category_name;
  final String category_image;
  final String created_at;
  final String updated_at;
  CategoryModel({
    required this.category_id,
    required this.category_name,
    required this.category_image,
    required this.created_at,
    required this.updated_at,
  });

  CategoryModel copyWith({
    String? category_id,
    String? category_name,
    String? category_image,
    String? created_at,
    String? updated_at,
  }) {
    return CategoryModel(
      category_id: category_id ?? this.category_id,
      category_name: category_name ?? this.category_name,
      category_image: category_image ?? this.category_image,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'category_id': category_id});
    result.addAll({'category_name': category_name});
    result.addAll({'category_image': category_image});
    result.addAll({'created_at': created_at});
    result.addAll({'updated_at': updated_at});

    return result;
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      category_id: map['category_id'] ?? '',
      category_name: map['category_name'] ?? '',
      category_image: map['category_image'] ?? '',
      created_at: map['created_at'] ?? '',
      updated_at: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryModel(category_id: $category_id, category_name: $category_name, category_image: $category_image, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryModel &&
        other.category_id == category_id &&
        other.category_name == category_name &&
        other.category_image == category_image &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return category_id.hashCode ^
        category_name.hashCode ^
        category_image.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
