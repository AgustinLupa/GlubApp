import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/imgs/backgound-image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        //color: Colors.lightBlue,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(
                'lib/assets/imgs/glider-image.png',
                fit: BoxFit.cover,
              ),
              MaterialButton(
                elevation: 5,
                minWidth: 200.0,
                height: 120.0,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Text(
                  "Listar aeronaves",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/list");
                },
              ),
              MaterialButton(
                elevation: 5,
                minWidth: 200.0,
                height: 120.0,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Text(
                  "Aeronaves en vuelo",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                onPressed: () {},
              ),
            ]),
      ),
      backgroundColor: const Color.fromARGB(255, 109, 183, 243),
    );
  }
}
