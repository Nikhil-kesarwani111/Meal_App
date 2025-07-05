import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/screens/Buy.dart';

// class MealDetailsScreen extends StatelessWidget {
//....................Notifier Provider
class MealDetailsScreen extends  ConsumerWidget{

  const MealDetailsScreen({
    super.key,
    required this.meal,
    // .................Notifier Provider
    // required this.onToggleFavorite,
  });

  final Meal meal;
  // .................Notifier Provider
  // final void Function(Meal meal) onToggleFavorite;

  @override
  // .................Notifier Provider
  // Widget build(BuildContext context) {
  Widget build(BuildContext context, WidgetRef ref) {
    //........now managing the star (favorite button)
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    final isFavorite = favoriteMeals.contains(meal);


    return Scaffold(
        appBar: AppBar(title: Text(meal.title), actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
              content: Text( wasAdded ? 'Meal added as a favorite.' : 'Meal removed.'),
              ),
              );
            },
           // icon: const Icon(Icons.star),
            //........now managing the star (favorite button)
            icon: Icon(isFavorite ? Icons.star : Icons.star_border),
          )
        ]),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 14),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              const SizedBox(height: 24),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              for (final step in meal.steps)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),

                  ),
                ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BillingScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.purple, // Background color
                  backgroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                ),
                child: const Text('Buy Now',style: TextStyle(color: Colors.black87,fontSize: 14, fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ));
  }
}