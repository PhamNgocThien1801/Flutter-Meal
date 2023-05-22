import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filter.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_menu.dart';
import 'package:meals/provider/meal_provider.dart';
import 'package:meals/provider/favorites_provider.dart';
import 'package:meals/provider/filter_provider.dart';

const KInitalFilters = {
  Filter.glutentFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarianFree: false,
  Filter.vegan: false,
};

class TabScreen extends ConsumerStatefulWidget {
  // xài provider của riverpod thì phải đổi từ SateFullWidget sang ConsumerStatefulWidget
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedIndex = 0;
  // final List<Meal> _favoriesMeals = [];

  // Map<Filter, bool> _selectedFilter = KInitalFilters;
  void _seclectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // void _showMessageFavories(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //     ),
  //   );
  // }

  // void _selectedFavoriesMeal(Meal meal) {
  //   final isExisting = _favoriesMeals.contains(meal);
  //   // tạo ra isExisting với kiểu true/false.
  //   //_favoriesMeal.contains(meal) được gọi để kiểm tra xem meal đầu vào đã tồn tại trong list của _favoriesMeal đã tồn tại hay chưa
  //   //nếu có thì trả về true nếu không thì trả về false
  //   if (isExisting) {
  //     setState(() {
  //       _favoriesMeals.remove(meal);
  //       _showMessageFavories('Your Favorite Food have remove');
  //     });
  //   } else {
  //     setState(() {
  //       _favoriesMeals.add(meal);
  //       _showMessageFavories('Added in your Favorite food');
  //     });
  //   }
  // }

  void _selectedScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filter') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(),
        ),
      );
      // setState(() {
      //   _selectedFilter = result ?? KInitalFilters;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealProvider);
    Widget selectedScreen = CategoriesScreen(
      // onToggleFavorites: _selectedFavoriesMeal,
      availableMeals: availableMeals,
    );

    var _selectedTitle = 'Category';

    if (_selectedIndex == 1) {
      final faviriesMeals = ref.watch(favoriteMealsProvider);
      selectedScreen = MealsScreen(
        meals: faviriesMeals,
        // onToggleFavorites: _selectedFavoriesMeal,
      );
      _selectedTitle = 'Your Favories';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedTitle),
      ),
      drawer: MainDrawer(
        onSelectedScreen: _selectedScreen,
      ), //để show thanh menu tượt bên góc trái,
      body: selectedScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _seclectedPage,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal_sharp),
            label: 'Category',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_rate), label: 'Favories'),
        ],
      ),
    );
  }
}

class $ {}
