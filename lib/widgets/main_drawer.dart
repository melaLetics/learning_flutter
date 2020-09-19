import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(IconData myIcon, String myTitle, Function tapHandler) {
    return ListTile(
      leading: Icon(
        myIcon,
        size: 26,
      ),
      title: Text(
        myTitle,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
          height: 120,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).accentColor,
          child: Text(
            'Cooking up!',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        buildListTile(
          Icons.restaurant,
          'Meals',
          () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        buildListTile(
          Icons.settings,
          'Filters',
          () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          },
        )
      ]),
    );
  }
}
