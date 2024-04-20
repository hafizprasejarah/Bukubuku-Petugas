class ResponseBook {
  ResponseBook({
    num? status,
    String? message,
    DataAddBook? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ResponseBook.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? DataAddBook.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  DataAddBook? _data;
  ResponseBook copyWith({  num? status,
    String? message,
    DataAddBook? data,
  }) => ResponseBook(  status: status ?? _status,
    message: message ?? _message,
    data: data ?? _data,
  );
  num? get status => _status;
  String? get message => _message;
  DataAddBook? get data => _data;

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

class DataAddBook {
  DataAddBook({
    String? kategoriId,
    String? judul,
    String? penulis,
    String? penerbit,
    String? tahunTerbit,
    String? image,
    String? updatedAt,
    String? createdAt,
    num? id,}){
    _kategoriId = kategoriId;
    _judul = judul;
    _penulis = penulis;
    _penerbit = penerbit;
    _tahunTerbit = tahunTerbit;
    _image = image;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  DataAddBook.fromJson(dynamic json) {
    _kategoriId = json['kategori_id'];
    _judul = json['judul'];
    _penulis = json['penulis'];
    _penerbit = json['penerbit'];
    _tahunTerbit = json['tahun_terbit'];
    _image = json['image'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  String? _kategoriId;
  String? _judul;
  String? _penulis;
  String? _penerbit;
  String? _tahunTerbit;
  String? _image;
  String? _updatedAt;
  String? _createdAt;
  num? _id;
  DataAddBook copyWith({  String? kategoriId,
    String? judul,
    String? penulis,
    String? penerbit,
    String? tahunTerbit,
    String? image,
    String? updatedAt,
    String? createdAt,
    num? id,
  }) => DataAddBook(  kategoriId: kategoriId ?? _kategoriId,
    judul: judul ?? _judul,
    penulis: penulis ?? _penulis,
    penerbit: penerbit ?? _penerbit,
    tahunTerbit: tahunTerbit ?? _tahunTerbit,
    image: image ?? _image,
    updatedAt: updatedAt ?? _updatedAt,
    createdAt: createdAt ?? _createdAt,
    id: id ?? _id,
  );
  String? get kategoriId => _kategoriId;
  String? get judul => _judul;
  String? get penulis => _penulis;
  String? get penerbit => _penerbit;
  String? get tahunTerbit => _tahunTerbit;
  String? get image => _image;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['kategori_id'] = _kategoriId;
    map['judul'] = _judul;
    map['penulis'] = _penulis;
    map['penerbit'] = _penerbit;
    map['tahun_terbit'] = _tahunTerbit;
    map['image'] = _image;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }

}
