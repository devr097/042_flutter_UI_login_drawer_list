import 'package:flutter/material.dart';
import 'package:sgmbooking/models/bookModel.dart';
import 'package:sgmbooking/utils/fonts.dart';
import 'package:intl/intl.dart';

class DetailData extends StatefulWidget {
  const DetailData({Key? key,required this.results}) : super(key: key);

  final Results results;

  @override
  _DetailDataState createState() => _DetailDataState();
}

class _DetailDataState extends State<DetailData> {

  int _value=0;

  // List<int> list_items=[0,1,2,3,4];
  late List<Stops> list_items;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(["widget.results.rute.stops:",widget.results.rute.stops]);
    _value  = widget.results.rute.stops.first.id;
    list_items = widget.results.rute.stops;
    // _value = Stops(id: 0, deleted: true, createdAt: "", updatedAt: "", name: "none", location: "none");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Details"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            SizedBox(height: 20),
            wdEachRow("Origin", widget.results.rute.origin.name),
            wdEachRow("Destination", widget.results.rute.destination.name),
            wdEachRow("StartTime", DateFormat('yyyy-MM-dd kk:mm').format(DateFormat("MM/dd/yy hh:mm").parse(widget.results.estimatedDeparture)).toString()),
            wdEachRow("ArrivalTime", DateFormat('yyyy-MM-dd kk:mm').format(DateFormat("MM/dd/yy hh:mm").parse(widget.results.estimatedArrival)).toString()),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: Text("Select bus stope"),
            ),
            Container(
              child: DropdownButton(
                value: _value,
                items: list_items.map((Stops item) {
                  return DropdownMenuItem<int>(
                    child: Text('Log ${item.name}'),
                    value: item.id,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _value = value as int;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 100,
        padding: EdgeInsets.only(bottom: 50),
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green, // background
            onPrimary: Colors.white, // foreground
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Confirm agenda'),
        ),
      ),
    );
  }


  wdEachRow(String title, String value){
    return Padding(padding: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Container(
                width:100,
                child: Text(title,style: black17_54)),
            Container(child: Text(value,style: black16)),
          ],
        ));
  }
}
