class Adres {
  int id;
  String idKod;
  String lokasyonunAdi;
  String lokasyonTuru;
  int altDugumVarmi;

  Adres(this.idKod,
      this.lokasyonunAdi,
      this.lokasyonTuru,
      this.altDugumVarmi);

  Adres.withID(this.id,
      this.idKod,
      this.lokasyonunAdi,
      this.lokasyonTuru,
      this.altDugumVarmi);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['idKod'] = idKod;
    map['lokasyonunAdi'] = lokasyonunAdi;
    map['lokasyonTuru'] = lokasyonTuru;
    map['altDugumVarmi'] = altDugumVarmi;

    return map;
  }

  Adres.fromMap(Map<String,dynamic> map)
  {
    this.id = map["id"];
    this.idKod = map["idKod"];
    this.lokasyonunAdi = map["lokasyonunAdi"];
    this.lokasyonTuru = map["lokasyonTuru"];
    this.altDugumVarmi = map["altDugumVarmi"];
  }

  @override
  String toString() {
    return 'Adres{id: $id, idKod: $idKod, lokasyonunAdi: $lokasyonunAdi, lokasyonTuru: $lokasyonTuru, altDugumVarmi: $altDugumVarmi}';
  }


}