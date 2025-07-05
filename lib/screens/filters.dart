
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

// import 'package:meals/screens/tabs.dart';
// import 'package:meals/widgets/main_drawer.dart';


//......................Filter provider
// enum Filter {
//   glutenFree,
//   lactoseFree,
//   vegetarian,
//   vegan,
// }



//........Filter provider
//class FiltersScreen extends StatefulWidget {
class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key,
    //.................Filter Notifier
    //required this.currentFilters
  });

 // final Map<Filter, bool> currentFilters;


  // ................................ converted to stateless widget

//   @override
//   ConsumerState<FiltersScreen> createState() {
//     return _FiltersScreenState();
//   }
// }
//
// class _FiltersScreenState extends ConsumerState<FiltersScreen> {
//   var _glutenFreeFilterSet = false;
//   var _lactoseFreeFilterSet = false;
//   var _vegetarianFilterSet = false;
//   var _veganFilterSet = false;



  // ...........due to filter screen now we switch it to local widget (stateful widget)
  // @override
  // void initState() {
  //   super.initState();
  //   //................................. filter Provider
  //   // replace widget
  //   // _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
  //   // _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
  //   // _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
  //   // _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  //   final activeFilters = ref.read(filtersProvider);
  //   _glutenFreeFilterSet = activeFilters[Filter.glutenFree]!;
  //   _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree]!;
  //   _vegetarianFilterSet = activeFilters[Filter.vegetarian]!;
  //   _veganFilterSet = activeFilters[Filter.vegan]!;
  // }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (ctx) => const TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),


      //.........note
    // body:PopScope(
    // canPop: false,
    // onPopInvoked: (bool didPop) {
    // ref.read(filtersProvider.notifier).setFilters({
    // Filter.glutenFree: _glutenFreeFilterSet,
    // Filter.lactoseFree: _lactoseFreeFilterSet,
    // Filter.vegetarian: _vegetarianFilterSet,
    // Filter.vegan: _veganFilterSet,
    // });
    // // if(didPop) return;
    // // Navigator.of(context).pop({
    // //   Filter.glutenFree: _glutenFreeFilterSet,
    // //   Filter.lactoseFree: _lactoseFreeFilterSet,
    // //   Filter.vegetarian: _vegetarianFilterSet,
    // //   Filter.vegan: _veganFilterSet,
    // // });
    // },
    // child: Column(
      body:
      Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              // setState(() {
              //   _glutenFreeFilterSet = isChecked;
              // });
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            subtitle: Text(
              'Only include gluten-free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            // value: _lactoseFreeFilterSet,
            // onChanged: (isChecked) {
            //   setState(() {
            //     _lactoseFreeFilterSet = isChecked;
            //   });
            // },
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: Text(
              'Lactose-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            subtitle: Text(
              'Only include lactose-free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            // value: _vegetarianFilterSet,
            // onChanged: (isChecked) {
            //   setState(() {
            //     _vegetarianFilterSet = isChecked;
            //   });
            // },
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            subtitle: Text(
              'Only include vegetarian meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            // value: _veganFilterSet,
            // onChanged: (isChecked) {
            //   setState(() {
            //     _veganFilterSet = isChecked;
            //   });
            // },
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            subtitle: Text(
              'Only include vegan meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
