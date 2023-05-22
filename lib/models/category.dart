import 'package:flutter/material.dart';

class Category {
  const Category({
    this.id,
    this.title,
    this.color = Colors.orange,
  });

  final id;
  final title;
  final color;
}
