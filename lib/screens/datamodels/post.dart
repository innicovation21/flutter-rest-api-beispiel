// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

// Diese Klasse haben wir mithilfe von https://app.quicktype.io/ erstellt
// vorgehen: siehe Dokumentation Basis-Kurs

import 'dart:convert';

// Vordefinierte Funktion zum Umwandeln Json in eine List<Post>
List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

// Vordefinierte Funktion zum Umwandeln einer List<Post> in Json
String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
