import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/meal_provider.dart';

enum Filter {
  glutentFree,
  lactoseFree,
  vegetarianFree,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutentFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarianFree: false,
          Filter.vegan: false,
        });
  void setFilters(Map<Filter, bool> choosenFilters) {
    state = choosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filteredMealProvider = Provider((ref) {
  final meal = ref.watch(providerMeals);
  final activeFilter = ref.watch(filtersProvider);
  return meal.where((meal) {
    if (activeFilter[Filter.glutentFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilter[Filter.vegetarianFree]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilter[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
