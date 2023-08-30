import 'package:firebase_and_flutter/models/brewsModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brewTile.dart';

class BrewsList extends StatefulWidget {
  const BrewsList({super.key});

  @override
  State<BrewsList> createState() => _BrewsListState();
}

class _BrewsListState extends State<BrewsList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<BrewsModel>>(context);

    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context, index) {
          return BrewTile(brew: brews[index]);
        });
  }
}
