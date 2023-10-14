import 'dart:convert';

class UserModel {
  final String account_id;
  final String username;
  final String password;
  final String first_name;
  final String last_name;
  final String short_name;
  UserModel({
    required this.account_id,
    required this.username,
    required this.password,
    required this.first_name,
    required this.last_name,
    required this.short_name,
  });

  UserModel copyWith({
    String? account_id,
    String? username,
    String? password,
    String? first_name,
    String? last_name,
    String? short_name,
  }) {
    return UserModel(
      account_id: account_id ?? this.account_id,
      username: username ?? this.username,
      password: password ?? this.password,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      short_name: short_name ?? this.short_name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'account_id': account_id});
    result.addAll({'username': username});
    result.addAll({'password': password});
    result.addAll({'first_name': first_name});
    result.addAll({'last_name': last_name});
    result.addAll({'short_name': short_name});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      account_id: map['account_id'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      first_name: map['first_name'] ?? '',
      last_name: map['last_name'] ?? '',
      short_name: map['short_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(account_id: $account_id, username: $username, password: $password, first_name: $first_name, last_name: $last_name, short_name: $short_name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.account_id == account_id &&
        other.username == username &&
        other.password == password &&
        other.first_name == first_name &&
        other.last_name == last_name &&
        other.short_name == short_name;
  }

  @override
  int get hashCode {
    return account_id.hashCode ^
        username.hashCode ^
        password.hashCode ^
        first_name.hashCode ^
        last_name.hashCode ^
        short_name.hashCode;
  }
}
