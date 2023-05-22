import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

final providerMeals = Provider(
  //Provider is only use for a lits never change if data chang use StateNotifierProvider
  (ref) {
    return dummyMeals;
  },
);
