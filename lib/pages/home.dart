import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 1),
    Band(id: '3', name: 'Heroes del silencio', votes: 2),
    Band(id: '4', name: 'Bon Jovi', votes: 5)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BandNames',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => bandTile(bands[i])),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), elevation: 1, onPressed: addNewBand),
    );
  }

  Widget bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('Direction: $direction');
        //TODO funcion para eliminar banda
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Delete band',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: ListTile(
          leading: CircleAvatar(
            child: Text(band.name.substring(0, 2)),
            backgroundColor: Colors.blue[100],
          ),
          title: Text(band.name),
          trailing: Text('${band.votes}', style: TextStyle(fontSize: 20)),
          onTap: () {
            print(band.name);
          }),
    );
  }

  addNewBand() {
    final textcontroller = new TextEditingController();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('New band name'),
              content: TextField(
                controller: textcontroller,
              ),
              actions: <Widget>[
                MaterialButton(
                    child: Text('Add'),
                    elevation: 1,
                    textColor: Colors.blue,
                    onPressed: () => addBandToList(textcontroller.text))
              ],
            ));
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
