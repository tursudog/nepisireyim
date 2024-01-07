import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:nepisireyim/models/recipe.dart';

import 'recipe_details_page.dart';


class RecipeCard extends StatelessWidget {
  final Recipe recipe; // Replace with your Recipe class definition

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => logAnalyicsEventAndGoToRecipeDetailsPage(context),
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child:  Image.network(
                recipe.imageUrl,
                width: double.infinity,
                height: 140,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // Image is loaded
                  } else {
                    return const Center(child: CircularProgressIndicator()); // Show loading indicator
                  }
                },
              ),
            ),
            const SizedBox(height: 3),
            Text(recipe.title, style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold)),
            Text(recipe.getTypeDisplayName(), style: const TextStyle(color: Colors.grey,fontSize: 16)),
            const SizedBox(height: 3),
          ],
        ),
      ),
    ),
    );
  }

  Future<void> logAnalyicsEventAndGoToRecipeDetailsPage(BuildContext context) async {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    await analytics.logEvent(
      name: 'screen_view',
      parameters: {
        'firebase_screen': "detailsPage",
        'firebase_screen_class': "detailsClass",
      },
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailsPage(recipe: recipe),
      ),
    );
  }
}