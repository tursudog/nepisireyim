import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nepisireyim/views/recipe_card.dart';

import '../models/recipe.dart';
import 'recipe_selection_page.dart';

class RecipeListPage extends StatefulWidget {
  final String filterType;
  final String displayName;

  const RecipeListPage({super.key, required this.filterType, required this.displayName});

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  final List<Recipe> _recipes = [];
  String displayString = "";

  @override
  void initState() {
    super.initState();
    _getRecipes();
    displayString = widget.displayName;
  }

  Future<void> _getRecipes() async {
    final menuCollection = FirebaseFirestore.instance
        .collection('new_recipes').where('type',isEqualTo: widget.filterType);
    await menuCollection.get().then((querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _recipes.add(Recipe.fromDocument(doc));
        });
      }
    });
  }

  CollectionReference newRecipesCollection =
  FirebaseFirestore.instance.collection('new_recipes');

  Stream<List<Recipe>> get recipes {
    return newRecipesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Recipe.fromDocument(doc)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(displayString),
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
