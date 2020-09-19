import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(
    this.currentFilters,
    this.saveFilters,
  );

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenfree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  bool _lactosefree = false;

  @override
  initState() {
    _glutenfree = widget.currentFilters['gluten'];
    _lactosefree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String subtitle,
    bool value,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      subtitle: Text(
        subtitle,
      ),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Filters'), actions: [
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            final selectedFilters = {
              'gluten': _glutenfree,
              'lactose': _lactosefree,
              'vegan': _vegan,
              'vegetarian': _vegetarian,
            };
            widget.saveFilters(selectedFilters);
          },
        )
      ]),
      drawer: MainDrawer(),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'Adjust your meal selection',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              _buildSwitchListTile(
                'Gluten-free',
                'Only includes gluten-free meals.',
                _glutenfree,
                (newValue) {
                  setState(() {
                    _glutenfree = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                'Vegetarian',
                'Only includes vegetarian meals',
                _vegetarian,
                (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                'Vegan',
                'Only includes vegan meals.',
                _vegan,
                (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                'Lactose-free',
                'Only includes lactose-free meals.',
                _lactosefree,
                (newValue) {
                  setState(() {
                    _lactosefree = newValue;
                  });
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
