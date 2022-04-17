import 'package:flutter/material.dart';
import 'package:json_parsing_demo/provider/myHomePageProvider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Saved'),
      ),
      body: ChangeNotifierProvider<MyHomePageProvider>(
        create: (context) => MyHomePageProvider(),
        child: Consumer<MyHomePageProvider>(
          builder: (context, provider, child) {
            if (provider.data == null) {
              provider.getData(context);
              return Center(child: CircularProgressIndicator());
            }
            // when we have the json loaded... let's put the data into a data table widget
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
              child: SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(
                        label: Text('Pinned'),
                        tooltip: 'Represents if the variant is pinned on the map.'),
                    DataColumn(
                        label: Text('Accession'),
                        tooltip: 'Represents the accession for the strand to be tracked back to GenBank'),
                    DataColumn(
                        label: Text('Geographic Location'),
                        tooltip: 'Represents the geographic area from which this strand was collected'),
                    DataColumn(
                        label: Text('Date Collected'),
                        tooltip: 'Represents the date the sample was collected'),
                    DataColumn(
                        label: Text('Length'),
                        tooltip: 'Represents the nucleotide length of the strand'),
                  ],
                  rows: provider.data.results
                      .map((data) =>
                          // we return a DataRow every time
                          DataRow(
                              // List<DataCell> cells is required in every row
                              cells: [
                                DataCell((data.pinned)
                                    ? Icon(
                                        Icons.push_pin,
                                        color: Colors.green,
                                      )
                                    : Icon(Icons.panorama_fish_eye, color: Colors.red)),
                                // I want to display a green color icon when user is verified and red when unverified
                                DataCell(Text(data.accession)),
                                DataCell(Text(data.geoLocation)),
                                DataCell(Text(data.dateCollected)),
                                DataCell(Text(data.length)),
                              ]))
                      .toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
