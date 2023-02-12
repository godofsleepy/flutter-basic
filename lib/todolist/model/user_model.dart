import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String? name;
  final String? username;
  final String? password;
  final String? pekerjaan;

  UserModel({
    this.name,
    this.username,
    this.password,
    this.pekerjaan,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'username': username,
      'password': password,
      'pekerjaan': pekerjaan,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] != null ? map['name'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      pekerjaan: map['pekerjaan'] != null ? map['pekerjaan'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? name,
    String? username,
    String? password,
    String? pekerjaan,
  }) {
    return UserModel(
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
      pekerjaan: pekerjaan ?? this.pekerjaan,
    );
  }
}
