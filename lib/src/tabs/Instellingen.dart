part of main;

class Instellingen extends StatefulWidget {
  @override
  _Instellingen createState() => _Instellingen();
}

class _Instellingen extends State<Instellingen> {
  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Kies een kleur"),
          content: BlockPicker(
            pickerColor: Theme.of(context).primaryColor,
            onColorChanged: (color) {
              setState(() {
                userdata.put("primaryColor", color.value);
                userdata.put("accentColor", color.value);
                print(userdata.get("primaryColor"));
              });
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box("userdata").listenable(),
      builder: (context, box, widget) {
        return ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text(
                "Uiterlijk",
                style: TextStyle(color: Colors.orange),
              ),
            ),
            ListTile(
              title: Text('Donker thema'),
              trailing: Switch.adaptive(
                value: box.get('darkMode', defaultValue: false),
                onChanged: (value) {
                  setState(() {
                    box.put("darkMode", value);
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Primaire kleur'),
              subtitle: Text(
                '#${Theme.of(context).primaryColor.value.toRadixString(16).substring(2, 8).toUpperCase()}',
              ),
              onTap: _showColorPicker,
              trailing: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('Secundaire kleur'),
              subtitle: Text(
                '#${Theme.of(context).accentColor.value.toRadixString(16).substring(2, 8).toUpperCase()}',
              ),
              onTap: _showColorPicker,
              trailing: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).accentColor,
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text(
                "Account",
                style: TextStyle(color: Colors.orange),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text(
                "Meldingen",
                style: TextStyle(color: Colors.orange),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text(
                "Overig",
                style: TextStyle(color: Colors.orange),
              ),
            ),
            ListTile(
              title: Text("Verander foto"),
              subtitle: Text("Verander je foto als die niet zo goed gelukt is."),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Kies een optie"),
                      content: DefaultTabController(
                        length: 3,
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          appBar: TabBar(
                            tabs: [
                              Tab(icon: Icon(Icons.face)),
                              Tab(icon: Icon(Icons.file_upload)),
                              Tab(icon: Icon(Icons.person)),
                            ],
                          ),
                          body: TabBarView(
                            children: [
                              Icon(Icons.directions_car),
                              Icon(Icons.directions_transit),
                              Icon(Icons.directions_bike),
                            ],
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            )
          ],
        );
      },
    );
  }
}
