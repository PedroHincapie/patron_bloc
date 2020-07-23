import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patron_bloc/empleado/bloc/empleado_bloc.dart';
import 'package:patron_bloc/empleado/model/empleado.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EmpleadoBloc empleadoBloc = EmpleadoBloc();

  //Lo mas importante son los dispose
  @override
  void dispose() {
    super.dispose();
    empleadoBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Pedro Rico'),
              accountEmail: Text('pedro.hincapie@ceiba.com'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Usuario'),
            ),
            ListTile(
              title: Text('Contacto'),
              leading: Icon(Icons.people),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('App Empleado BLoC'),
      ),
      body: Container(
        child: StreamBuilder<List<Empleado>>(
          initialData: [],
          stream: empleadoBloc.listaEmpleadosStrem,
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Empleado>> snapshot,
          ) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (
                context,
                index,
              ) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  color: Colors.white70,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          '${snapshot.data[index].uid}.',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '${snapshot.data[index].nombre}',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              '\$ ${snapshot.data[index].salario}',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.thumb_up,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            empleadoBloc.incremendarSalarioSink
                                .add(snapshot.data[index]);
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.thumb_down,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            empleadoBloc.decrementarSalarioSink
                                .add(snapshot.data[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
