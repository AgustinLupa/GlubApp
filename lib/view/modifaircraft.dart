import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:glubapp/models/aircraftsviewmodel.dart';

import '../services/remote_services.dart';

final List<String> listItems = [
  'Avion',
  'Planeador',
];
String? selectedValue;
String? plateValue;
String? oldPlateValue;

List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
  List<DropdownMenuItem<String>> menuItems = [];
  for (var item in items) {
    menuItems.addAll(
      [
        DropdownMenuItem<String>(
          value: item,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        //If it's last item, we will not add Divider after it.
        if (item != items.last)
          const DropdownMenuItem<String>(
            enabled: false,
            child: Divider(),
          ),
      ],
    );
  }
  return menuItems;
}

Future<Future> _modifAircraft(
    BuildContext context, String oldplate, String newPlate, String type) async {
  final result = await RemoteService().modifAircraft(oldplate, newPlate, type);
  // ignore: use_build_context_synchronously
  return showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: const Text('Resultado'),
            content: Text(result),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Aceptar'),
              ),
            ],
          )));
}

class ModifAircraft extends StatefulWidget {
  final AircraftViewModel aircraftViewModel;

  const ModifAircraft({Key? key, required this.aircraftViewModel})
      : super(key: key);

  @override
  State<ModifAircraft> createState() => _ModifAircraftState();
}

class _ModifAircraftState extends State<ModifAircraft> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 70, 122, 242),
        automaticallyImplyLeading: false,
        title: const Text(
          'Modificar Aeronave',
          style: TextStyle(
            fontFamily: 'Lexend Deca',
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 24,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: IconButton(
              icon: const Icon(
                Icons.close_rounded,
                color: Color.fromARGB(255, 255, 255, 255),
                size: 30,
              ),
              onPressed: () async {
                Navigator.pushNamed(context, '/list');
              },
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          child: Form(
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16, 30, 16, 40),
                        child: TextFormField(
                          onChanged: (value) => plateValue = value,
                          initialValue: oldPlateValue =
                              widget.aircraftViewModel.plate.toString(),
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Matricula',
                            labelStyle: const TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF57636C),
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 146, 191, 250),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 146, 191, 250),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 146, 191, 250),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 146, 191, 250),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    20, 32, 20, 12),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF14181B),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                          maxLength: 6,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16, 12, 16, 25),
                        child: DropdownButton2(
                          isExpanded: true,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: const Color.fromARGB(255, 63, 177, 253),
                              width: 1.5,
                            ),
                          ),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color.fromARGB(255, 63, 177, 253),
                            ),
                          ),
                          hint: Text(
                            'Tipo de aeronave',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Lexend Deca',
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          items: _addDividersAfterItems(listItems),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                          },
                          buttonHeight: 50,
                          dropdownMaxHeight: 300,
                          buttonWidth: 400,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 2.0),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF57636C),
                            size: 40,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 130),
                    child: MaterialButton(
                      onPressed: () async {
                        _modifAircraft(context, oldPlateValue!,
                            plateValue!.toUpperCase(), selectedValue!);
                      },
                      minWidth: 270,
                      height: 50,
                      color: const Color(0xFF4B39EF),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: const Text(
                        'Modificar Aeronave',
                        style: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
