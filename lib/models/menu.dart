import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  final String ana_yemek;
  final String yan_yemek;
  final String corba;
  final String tatli;

  Menu({
    required this.ana_yemek,
    required this.yan_yemek,
    required this.corba,
    required this.tatli,
  });

  factory Menu.fromDocument(DocumentSnapshot data) {
    return Menu(
      ana_yemek: data["ana_yemek"],
      yan_yemek: data['yan_yemek'],
      corba: data['corba'],
      tatli: data['tatli'],
    );
  }
}
