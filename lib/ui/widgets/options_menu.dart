import 'package:flutter/material.dart';
import 'package:flutter_projects/models/lawyer.dart';
import 'package:flutter_projects/viewModels/lawyer_viewModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionsMenuItems extends StatefulWidget {
  Future<List<Lawyer>> list;
  Future<Position> position;

  OptionsMenuItems({Key? key, required this.list, required this.position}) : super(key: key);

  @override
  State<OptionsMenuItems> createState() => _OptionsMenuItemsState();
}

class _OptionsMenuItemsState extends State<OptionsMenuItems> {
  List<Lawyer> fullList = [];
  late SharedPreferences prefs;
  int? _selectedCityIndex;
  int? _selectedDistanceIndex;
  int? _selectedSpecialityIndex;

  final List _cities = ['Abu Dhabi', 'Dubai', 'Sharja', 'Ajman', 'Umm Al Quwain',
    'Ras Al Khaimah', 'Ras Al Khaimah' ];

  final List _distances = ['10KM', '30KM', '50KM', '70KM', '90KM',
    '110KM', '130KM' ];

  final List _specialities = ['Consultancy', 'Commercial', 'Legacy'];

  saveSharedPreferences({required bool value}) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('key', value);
  }

  getSharedPreferencesValues({required bool value}) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('key', value);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      child: const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        const PopupMenuItem(
            value: 0,
            child: ListTile(
              title: Text('Filters'),
              leading: Icon(Icons.filter_list),
            )
        ),
        const PopupMenuItem(
            value: 1,
            child: ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
            )
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 0: {
            showModalBottomSheet(
              isDismissible: false,
              context: context,
                isScrollControlled:true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter chipState){
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          children: _buildChips(chipState),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          break;
          case 1: {

          }
          break;
        }
      },
    );
  }

  List<Widget> _buildChips(StateSetter chipState){
    List<Widget> chips = [];
    chips.addAll(_buildCitiesChips(chipState));
    chips.addAll(_buildDistanceChips(chipState));
    chips.addAll(_buildSpecialityChips(chipState));
    chips.add(const Divider());
    chips.add(const SizedBox(height: 70));
    chips.add(FloatingActionButton.extended(
      elevation: 20,
        label: const Text('Apply'),
        backgroundColor: Colors.black,
        onPressed: (){

        }
    ));
    return chips;
  }

  List<Widget> _buildDistanceChips (StateSetter chipState) {
    List<Widget> chips = [];
    for (int i = 0; i < _distances.length; i++) {
      chips.add(ChoiceChip(
        elevation: 10,
        label: Text(_distances[i]),
        selectedColor: Colors.amber,
        selected: _selectedDistanceIndex == i,
        onSelected: (bool selected) {
          chipState((){
            if (!selected) {
              _selectedDistanceIndex = null;
            }
            else {
              _selectedDistanceIndex = i;
            }
          });
        },
      ));
      if(i == _distances.length-1) {
        chips.add(const Divider());
      }
    }
    return chips;
  }

  List<Widget> _buildCitiesChips (StateSetter chipState) {
    List<Widget> chips = [];
    for (int i = 0; i < _cities.length; i++) {
      chips.add(ChoiceChip(
        elevation: 10,
        label: Text(_cities[i]),
        avatar: const Icon(Icons.location_on_outlined),
        selectedColor: Colors.amber,
        selected: _selectedCityIndex == i,
        onSelected: (bool selected) {
          chipState((){
            if (!selected) {
              _selectedCityIndex = null;
            }
            else {
              _selectedCityIndex = i;
            }
          });
        },
      ));
      if(i == _cities.length-1) {
        chips.add(const Divider());
      }
    }
    return chips;
  }

  List<Widget> _buildSpecialityChips (StateSetter chipState) {
    List<Widget> chips = [];
    for (int i = 0; i < _specialities.length; i++) {
      chips.add(ChoiceChip(
        elevation: 10,
        label: Text(_specialities[i]),
        selectedColor: Colors.amber,
        selected: _selectedSpecialityIndex == i,
        onSelected: (bool selected) {
          chipState((){
            if (!selected) {
              _selectedSpecialityIndex = null;
            }
            else {
              _selectedSpecialityIndex = i;
            }
          });
        },
      ));
    }
    return chips;
  }
}
