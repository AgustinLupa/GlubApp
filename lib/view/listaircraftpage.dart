import 'package:flutter/material.dart';
import 'package:glubapp/models/aircrafts.dart';
import 'package:glubapp/models/aircraftsviewmodel.dart';
import 'package:glubapp/services/remote_services.dart';

import 'modifaircraft.dart';

Color getColorFromResponse(String response) {
  if (response == "En tierra") {
    return Colors.red;
  } else {
    return Colors.green;
  }
}

class ListAircraftPage extends StatefulWidget {
  const ListAircraftPage({super.key});

  @override
  State<ListAircraftPage> createState() => _ListAircraftPageState();
}

class _ListAircraftPageState extends State<ListAircraftPage> {
  List<Aircrafts>? aircrafts;
  List<AircraftViewModel>? aircraftViewModel = List.empty(growable: true);
  var isloaded = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<void> _showModifAircraft(
      BuildContext context, AircraftViewModel aircraftViewModel) async {
    return showDialog<void>(
        context: context,
        builder: ((context) => ModifAircraft(
              aircraftViewModel: aircraftViewModel,
            )));
  }

  getData() async {
    aircrafts = await RemoteService().getAll();

    if (aircrafts != null) {
      AircraftViewModel air;
      for (Aircrafts aircraft in aircrafts!) {
        air = AircraftViewModel(aircraft);
        aircraftViewModel?.add(air);
      }
      setState(() {
        isloaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color.fromARGB(255, 247, 247, 247),
            size: 30,
          ),
          onPressed: () async => Navigator.pushNamed(context, '/'),
        ),
        title: const Text('Lista de aeronaves'),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
            child: InkWell(
              onTap: () async {
                //context.pushNamed('/newAircraft');
                Navigator.pushNamed(context, "/newAircraft");
              },
              child:
                  const Icon(Icons.add_rounded, color: Colors.white, size: 35),
            ),
          )
        ],
      ),
      body: Visibility(
        visible: isloaded,
        // ignore: sort_child_properties_last
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 12),
                  child: Text(
                    '\n',
                    style: TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF95A1AC),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
              child: ListView.builder(
                  itemCount: aircraftViewModel?.length,
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: const Text('Modificar'),
                              content: Text(
                                  'Desea modificar la aeronave ${aircraftViewModel![index].plate.toString()}?'),
                              actions: [
                                TextButton(
                                  onPressed: () => _showModifAircraft(
                                      alertDialogContext,
                                      aircraftViewModel![index]),
                                  child: const Text(' Modificar '),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext),
                                  child: const Text(' Poner en vuelo '),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext),
                                  child: const Text(
                                    ' Cancelar ',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                        child: Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 195, 214, 233),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 3,
                                color: Color(0x430F1113),
                                offset: Offset(0, 1),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 4, 12, 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 4, 0, 4),
                                      child: Text(
                                        aircraftViewModel![index]
                                            .aircraftType
                                            .toString(),
                                        style: const TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Color(0xFF4B39EF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                height: 1,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF1F4F8),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 4, 12, 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 4, 0, 0),
                                      child: Text(
                                        aircraftViewModel![index]
                                            .plate
                                            .toString(),
                                        style: const TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Color(0xFF090F13),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 4, 12, 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        aircraftViewModel![index]
                                            .isFlying
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: getColorFromResponse(
                                              aircraftViewModel![index]
                                                  .isFlying
                                                  .toString()),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
