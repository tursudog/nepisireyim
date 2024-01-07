import 'package:flutter/material.dart';
import 'package:nepisireyim/views/home_page_view.dart';
import 'package:nepisireyim/views/recipe_list_page.dart';

class RecipeSelectionPage extends StatelessWidget {
  const RecipeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Tarifler"),
          backgroundColor: const Color(0xFF861920)
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        mainAxisSpacing: 9,
        crossAxisSpacing: 16,
        children: [
          ImageButton(
            imagePath: 'assets/images/main_course.png',
            buttonText: 'Ana Yemekler',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecipeListPage(filterType: "ana_yemek",displayName: "Ana Yemekler"),
                ),
              );
              },
          ),
          ImageButton(
            imagePath: 'assets/images/side_dish.png',
            buttonText: 'Yan Yemekler',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecipeListPage(filterType: "yan_yemek", displayName: "Yan Yemekler"),
                ),
              );            },
          ),
          ImageButton(
            imagePath: 'assets/images/soup.png',
            buttonText: 'Çorbalar',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecipeListPage(filterType: "corba",displayName: "Çorbalar"),
                ),
              );            },
          ),
          ImageButton(
            imagePath: 'assets/images/dessert.png',
            buttonText: 'Tatlılar',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecipeListPage(filterType: "tatli",displayName: "Tatlılar"),
                ),
              );            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor:  const Color(0xFF861920),
        onTap: (index) {
          if(index == 0){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>const MenuPageView(showDialogOnFirstOpen: false),
              ),
            );
          }
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

class ImageButton extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final VoidCallback onPressed;

  const ImageButton({super.key,
    required this.imagePath,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 150,
              height: 150,
            ),
            Text(buttonText,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8,)
          ],
        ),
      ),
    );
  }
}