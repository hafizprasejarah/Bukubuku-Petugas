class ResponseSingleBook {
  ResponseSingleBook({
    required num? status,
    required String? message,
    required DataSingleBook? data,
  }){
    _status = status;
    _message = message;
    _data = data;
  }

  ResponseSingleBook.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? DataSingleBook.fromJson(json['data']) : null;
  }

  num? _status;
  String? _message;
  DataSingleBook? _data;

  num? get status => _status;
  String? get message => _message;
  DataSingleBook? get data => _data;

// Metode toJson() tidak perlu diubah karena properti-propertinya sudah nullable
}

class DataSingleBook {
  DataSingleBook({
    required num? id,
    required num? kategoriId,
    required String? judul,
    required String? image,
    required String? description,
    required String? penulis,
    required String? penerbit,
    required num? tahunTerbit,
    required String? createdAt,
    required String? updatedAt,
  }){
    _id = id;
    _kategoriId = kategoriId;
    _judul = judul;
    _image = image;
    _description = description;
    _penulis = penulis;
    _penerbit = penerbit;
    _tahunTerbit = tahunTerbit;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  DataSingleBook.fromJson(dynamic json) {
    _id = json['id'];
    _kategoriId = json['kategori_id'];
    _judul = json['judul'];
    _image = json['image'];
    _description = json['description'];
    _penulis = json['penulis'];
    _penerbit = json['penerbit'];
    _tahunTerbit = json['tahun_terbit'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _kategoriId;
  String? _judul;
  String? _image;
  String? _description;
  String? _penulis;
  String? _penerbit;
  num? _tahunTerbit;
  String? _createdAt;
  String? _updatedAt;

  num? get id => _id;
  num? get kategoriId => _kategoriId;
  String? get judul => _judul;
  String? get image => _image;
  String? get description => _description;
  String? get penulis => _penulis;
  String? get penerbit => _penerbit;
  num? get tahunTerbit => _tahunTerbit;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

// Metode toJson() tidak perlu diubah karena properti-propertinya sudah nullable
}
