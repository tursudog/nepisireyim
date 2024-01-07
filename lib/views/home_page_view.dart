import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nepisireyim/views/recipe_card.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/recipe.dart';
import 'recipe_selection_page.dart';

class MenuPageView extends StatefulWidget {
  final bool showDialogOnFirstOpen;

  const MenuPageView( {super.key, required this.showDialogOnFirstOpen});

  @override
  State<MenuPageView> createState() => _MenuPageViewState();
}

class _MenuPageViewState extends State<MenuPageView> {
  final List<Recipe> _recipes = [];

  @override
  void initState() {
    super.initState();
    if (widget.showDialogOnFirstOpen) {
      Future.delayed(Duration.zero, () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Kullanım Koşulları'),
              content: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Kullanıcılarımız, uygulamamızı kullanarak, ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Gizlilik sözleşmemizi ',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () { launch('https://firebasestorage.googleapis.com/v0/b/nepisireyim.appspot.com/o/new_privacy.html?alt=media&token=9072ddd7-e9c1-4d9a-bc62-b90194bcaed4');
                        },
                    ),
                    const TextSpan(
                      text: 've ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Kullanım koşullarımızı ',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () { launch('https://firebasestorage.googleapis.com/v0/b/nepisireyim.appspot.com/o/new_terms.html?alt=media&token=88616c2d-be97-4146-9b13-2ffc63bf682c');
                        },
                    ),
                    const TextSpan(
                      text: 'kabul ettiğinizi beyan etmiş olurlar.',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:
                  const Text(style: TextStyle(color: Color(0xFF861920)),'Kabul et'),
                ),
              ],
            );
          },
        );
      });
    }
    _getMenu();

  }

  Future<void> _getMenu() async {
    final menuCollection = FirebaseFirestore.instance
        .collection('new_menu')
        .orderBy(FieldPath.documentId);
    await menuCollection.get().then((querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        final recipeId = doc['id']; // Get recipe ID from "menu" document
        await _fetchRecipeById(recipeId);
      }
    });
  }

  Future<void> _fetchRecipeById(String recipeId) async {
    if (recipeId.isEmpty) {
      return;
    }
    final recipeDoc = await FirebaseFirestore.instance
        .collection('new_recipes')
        .doc(recipeId)
        .get();
    if (recipeDoc.exists) {
      final recipe = Recipe.fromDocument(recipeDoc);
      setState(() {
        _recipes.add(recipe);
      });
    }
  }

  // Access the "new_recipes" collection
  CollectionReference newRecipesCollection =
  FirebaseFirestore.instance.collection('new_recipes');

  // Fetch all documents from the collection
  Stream<List<Recipe>> get recipes {
    return newRecipesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Recipe.fromDocument(doc)).toList();
    });
  }


  CollectionReference menuCollection =
  FirebaseFirestore.instance.collection('new_menu');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("~ Günün Menüsü ~"),
        centerTitle: true,
        backgroundColor: const Color(0xFF861920)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            StreamBuilder<List<Recipe>>(
                stream: recipes, // Stream of Recipe objects from Firestore
                builder: (context, snapshot) {
                  return Column(
                    children: _recipes
                        .map((recipe) => RecipeCard(recipe: recipe))
                        .toList(),
                  );
                })
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor:  const Color(0xFF861920),

        onTap: (index) {
          setState(() {
            if(index == 1){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>const RecipeSelectionPage(),
                ),
              );
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Günün Menüsü',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Tarifler',
          ),
        ],
      ),
    );
  }

}
