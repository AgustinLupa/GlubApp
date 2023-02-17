import 'package:flutter/material.dart';
import 'package:glubapp/models/aircrafts.dart';
import 'package:glubapp/models/aircraftsviewmodel.dart';
import 'package:glubapp/services/remote_services.dart';

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
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
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
                                      style: const TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Color.fromARGB(255, 230, 30, 30),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),

        // child: ListView.builder(
        //   itemCount: aircraftViewModel?.length,
        //   itemBuilder: (context, index) {
        //     return Container(
        //       child: Column(
        //         mainAxisSize: MainAxisSize.max,
        //         children: [
        //           Row(
        //             mainAxisSize: MainAxisSize.max,
        //             children: const [
        //               Padding(
        //                 padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 12),
        //                 child: Text(
        //                   '\n',
        //                   style: TextStyle(
        //                     fontFamily: 'Lexend Deca',
        //                     color: Color(0xFF95A1AC),
        //                     fontSize: 14,
        //                     fontWeight: FontWeight.normal,
        //                   ),
        //                 ),
        //               )
        //             ],
        //           ),
        //           Padding(
        //             padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
        //             child: ListView(
        //               padding: EdgeInsets.zero,
        //               primary: false,
        //               shrinkWrap: true,
        //               scrollDirection: Axis.vertical,
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsetsDirectional.fromSTEB(
        //                       16, 0, 16, 8),
        //                   child: Container(
        //                     width: double.infinity,
        //                     decoration: BoxDecoration(
        //                       color: const Color.fromARGB(255, 195, 214, 233),
        //                       boxShadow: const [
        //                         BoxShadow(
        //                           blurRadius: 3,
        //                           color: Color(0x430F1113),
        //                           offset: Offset(0, 1),
        //                         )
        //                       ],
        //                       borderRadius: BorderRadius.circular(9),
        //                     ),
        //                     child: Column(
        //                       mainAxisSize: MainAxisSize.max,
        //                       children: [
        //                         Padding(
        //                           padding: const EdgeInsetsDirectional.fromSTEB(
        //                               12, 4, 12, 4),
        //                           child: Row(
        //                             mainAxisSize: MainAxisSize.max,
        //                             children: [
        //                               Padding(
        //                                 padding: const EdgeInsetsDirectional
        //                                     .fromSTEB(0, 4, 0, 4),
        //                                 child: Text(
        //                                   aircraftViewModel![index]
        //                                       .aircraftType
        //                                       .toString(),
        //                                   style: const TextStyle(
        //                                     fontFamily: 'Lexend Deca',
        //                                     color: Color(0xFF4B39EF),
        //                                     fontSize: 14,
        //                                     fontWeight: FontWeight.w600,
        //                                   ),
        //                                 ),
        //                               )
        //                             ],
        //                           ),
        //                         )
        //                       ],
        //                     ),
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ),
        //         ],

        //       ),
        //     );
        //   },
        // ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
