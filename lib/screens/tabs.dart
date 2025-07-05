import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; //for ConsumerStatefulWidget

// import 'package:meals/data/dummy_data.dart';

//........Filter provider  Now we can not use the meal model
// import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/meals_provider.dart';

//..............filter Provider
// const kInitialFilters = {
//   Filter.glutenFree: false,
//   Filter.lactoseFree: false,
//   Filter.vegetarian: false,
//   Filter.vegan: false
// };

//class TabsScreen extends StatefulWidget {
// Due to provider
// If here is a stateless widget then i replace it with ConsumerWidget
  class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  //replace state with ConsumerState
  ConsumerState<TabsScreen> createState() {
  return _TabsScreenState();
  }
  }
//replace state with ConsumerState
  class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // filter Provider
  //final List<Meal> _favoriteMeals = [];
  //.................. Notifier Provider
  // no use
  //Map<Filter, bool> _selectedFilters = kInitialFilters;


  //..............Notifier Provider
  // void _showInfoMessage(String message) {
  // ScaffoldMessenger.of(context).clearSnackBars();
  // ScaffoldMessenger.of(context).showSnackBar(
  // SnackBar(
  // content: Text(message),
  // ),
  // );
  // }

  //Because of Notifier provider

  // void _toggleMealFavoriteStatus(Meal meal) {
  // final isExisting = _favoriteMeals.contains(meal);
  //
  // if (isExisting) {
  // setState(() {
  // _favoriteMeals.remove(meal);
  // });
  // _showInfoMessage('Meal is no longer a favorite.');
  // } else {
  // setState(() {
  // _favoriteMeals.add(meal);
  // _showInfoMessage('Marked as a favorite!');
  // });
  // }
  // }

  void _selectPage(int index) {
  setState(() {
  _selectedPageIndex = index;
  });
  }

  void _setScreen(String identifier) async {
  Navigator.of(context).pop();
  if (identifier == 'filters') {
    //.................. Notifier Provider
    //no return value of filterScreen
    //final result = await Navigator.of(context).push<Map<Filter, bool>>(

  await Navigator.of(context).push<Map<Filter, bool>>(
  MaterialPageRoute(
  builder: (ctx) => const FiltersScreen(
  //currentFilters: _selectedFilters,
  ),
  ),
  );

  //.................. Notifier Provider
    // no use of this now
  // setState(() {
  // _selectedFilters = result ?? kInitialFilters;
  // });
  }
  }

  @override
  Widget build(BuildContext context) {
  // final availableMeals = dummyMeals.where((meal) {
  //Now apply method Provider
    // ..........................................
 // a ref property is available that allows us to set up listeners to our provider
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);
    final availableMeals = meals.where((meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    //.................Filter Provider
  // final availableMeals = meals.where((meal) {
  // if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
  // return false;
  // }
  // if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
  // return false;
  // }
  // if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
  // return false;
  // }
  // if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
  // return false;
  // }
  // return true;
  // }).toList();
  //In summary, return true ensures that only meals meeting all the selected
  // filter conditions are included in the resulting availableMeals list.
  // If a meal fails any of the conditions, it is excluded by returning false.

  Widget activePage = CategoriesScreen(
  // onToggleFavorite: _toggleMealFavoriteStatus,
  availableMeals: availableMeals,
  );
  var activePageTitle = 'Categories';

  if (_selectedPageIndex == 1) {
    //..........................................Notifier Provider
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    //.....................................................
  activePage = MealsScreen(
 // meals: _favoriteMeals,
    meals: favoriteMeals,
  // onToggleFavorite: _toggleMealFavoriteStatus,
  );
  activePageTitle = 'Your Favorites';
  }

  return Scaffold(
  appBar: AppBar(
  title: Text(activePageTitle),
  ),
  drawer: MainDrawer(
  onSelectScreen: _setScreen,
  ),
  body: activePage,
  bottomNavigationBar: BottomNavigationBar(
  onTap: _selectPage,
  currentIndex: _selectedPageIndex,
  items: const [
  BottomNavigationBarItem(
  icon: Icon(Icons.set_meal),
  label: 'Categories',
  ),
  BottomNavigationBarItem(
  icon: Icon(Icons.star),
  label: 'Favorites',
  ),
  ],
  ),
  );
  }
  }
