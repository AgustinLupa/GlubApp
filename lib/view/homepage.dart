import 'package:flutter/material.dart';
import 'package:glubapp/models/aircrafts.dart';
import 'package:glubapp/models/aircraftsviewmodel.dart';
import 'package:glubapp/services/remote_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: const Text('Aircrafts'),
      ),
      body: Visibility(
        visible: isloaded,
        child: ListView.builder(
          itemCount: aircraftViewModel?.length,
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    aircraftViewModel![index].plate,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    aircraftViewModel![index].aircraftType.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    aircraftViewModel![index].isFlying.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
