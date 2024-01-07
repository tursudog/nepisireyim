import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  final String id;
  final String title;
  final String type;
  final String urlPrefix;
  final List<String> sideTypes;
  final List<String> ingredients;
  final String instructions;
  final String imageUrl;
  final List<String> tags;

  Recipe({
    required this.id,
    required this.title,
    required this.type,
    required this.urlPrefix,
    required this.sideTypes,
    required this.ingredients,
    required this.instructions,
    required this.imageUrl,
    required this.tags,
  });

  factory Recipe.fromDocument(DocumentSnapshot data) {
    return Recipe(
      id: data["id"],
      title: data['title'],
      type: data['type'],
      urlPrefix: data['urlPrefix'],
      sideTypes: List<String>.from(data['sideTypes'] ?? []),
      ingredients:List<String>.from(data['ingredients'] ?? []),
      instructions: data['instructions'],
      imageUrl: data['imageUrl'],
      tags: List<String>.from(data['tags'] ?? []),
    );
  }

  String getTypeDisplayName() {
    switch (type) {
      case "ana_yemek":
        return "Ana Yemek";
      case "yan_yemek":
        return "Yan Yemek";
      case "corba":
        return "Çorba";
      case "tatli":
        return "Tatlı";
      default:
        return "";
    }
  }




}
