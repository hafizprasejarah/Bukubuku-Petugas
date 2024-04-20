class ResponseAddKategori {
  ResponseAddKategori({
    num? status,
    String? message,
    DataAddkategori? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ResponseAddKategori.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data =
    json['data'] != null ? DataAddkategori.fromJson(json['data']) : null;
  }

  num? _status;
  String? _message;
  DataAddkategori? _data;

  num? get status => _status;
  String? get message => _message;
  DataAddkategori? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data!.toJson();
    }
    return map;
  }
}

class DataAddkategori {
  DataAddkategori({
    String? nama,
    String? updatedAt,
    String? createdAt,
    num? id,
  }) {
    _nama = nama;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  DataAddkategori.fromJson(dynamic json) {
    _nama = json['nama'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }

  String? _nama;
  String? _updatedAt;
  String? _createdAt;
  num? _id;

  String? get nama => _nama;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nama'] = _nama;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }
}
