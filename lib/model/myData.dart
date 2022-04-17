class MyData {
  String previous;
  String next;
  List<Results> results;

  MyData.fromJson(Map<String, dynamic> json) {
    previous = json['previous'];
    next = json['next'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }
}

class Results {
  String accession;
  String geoLocation;
  String dateCollected;
  String length;
  bool pinned;

  Results.fromJson(Map<String, dynamic> json) {
    accession = json['accession'];
    geoLocation = json['geoLocation'];
    dateCollected = json['dateCollected'];
    length = json['length'];
    pinned = json['pinned'];
  }
}
