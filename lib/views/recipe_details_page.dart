import 'package:flutter/material.dart';
import 'package:nepisireyim/models/recipe.dart';



class RecipeDetailsPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${recipe.title} Tarifi"),
        backgroundColor: const Color(0xFF861920),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Recipe image
            Image.network(
              recipe.imageUrl,
              width: double.infinity,
              height: 250, // Adjust height as needed
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const SizedBox(height: 3),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Malzemeler:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (String ingredient in recipe.ingredients)
                    Text(ingredient),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Hazırlanış:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(recipe.instructions),
            ),
          ],
        ),
      ),
    );
  }
}
