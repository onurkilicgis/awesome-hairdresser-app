class HairDressers {
  String? status;
  String? message;
  Data? data;
  String? code;

  HairDressers(
    this.status,
    this.message,
    this.data,
    this.code,
  );
  HairDressers.fromJson(json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? type;
  List<Features>? features;

  Data(this.type, this.features);

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['features'] != null) {
      features = [];
      json['features'].forEach((value) {
        features?.add(Features.fromJson(value));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = this.type;
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Features {
  String? type;
  Geometry? geometry;
  Properties? properties;

  Features(this.type, this.geometry, this.properties);

  Features.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
  }

  get il => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
    return data;
  }
}

class Geometry {
  String? type;
  List<double>? coordinates;

  Geometry(this.type, this.coordinates);
  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class Properties {
  int? index;
  String? geotype;
  String? adi;
  double? puan;
  String? il;
  String? ilce;
  int? fiyat;

  Properties(
      {this.index,
      this.geotype,
      this.adi,
      this.puan,
      this.il,
      this.ilce,
      this.fiyat});

  Properties.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    geotype = json['geotype'];
    adi = json['adi'];
    puan = double.parse(json['puan'].toString());
    il = json['il'];
    ilce = json['ilce'];
    fiyat = json['fiyat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['geotype'] = this.geotype;
    data['adi'] = this.adi;
    data['puan'] = this.puan;
    data['il'] = this.il;
    data['ilce'] = this.ilce;
    data['fiyat'] = this.fiyat;
    return data;
  }
}
