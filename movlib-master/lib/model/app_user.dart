import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

AppUser appUserFromJson(String str) => AppUser.fromJson(json.decode(str));

String appUserToJson(AppUser data) => json.encode(data.toJson());

class AppUser {
  AppUser({
    this.displayName,
    this.imageUrl,
    this.tag,
    this.id,
    this.following,
    this.followers,
  });

  String displayName;
  String imageUrl;
  String tag;
  String id;
  int following;
  int followers;

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        displayName: json["displayName"] == null ? null : json["displayName"],
        imageUrl: json["imageURL"] == null ? null : json["imageURL"],
        tag: json["tag"] == null ? null : json["tag"],
        id: json["id"] == null ? null : json["id"],
        following: json["following"] == null ? 0 : json["following"],
        followers: json["followers"] == null ? 0 : json["followers"],
      );

  factory AppUser.fromFirebaseUser(User user) {
    String tag = '@';
    List<String> names = user.displayName.split(' ');
    tag += names.first;
    tag += user.uid.substring(0, 5);

    return AppUser(
        id: user.uid,
        displayName: user.displayName,
        imageUrl: user.photoURL,
        tag: tag,
        followers: 0,
        following: 0);
  }

  Map<String, dynamic> toJson() => {
        "displayName": displayName == null ? null : displayName,
        "imageURL": imageUrl == null ? null : imageUrl,
        "tag": tag == null ? null : tag,
        "id": id == null ? null : id,
        "following": following ?? 0,
        "followers": followers ?? 0,
      };

  Map<String, dynamic> toReviewJson() => {
    "id": id == null ? null : id,
    "imageURL": imageUrl == null ? null : imageUrl,
    "tag": tag == null ? null : tag,
  };
}
