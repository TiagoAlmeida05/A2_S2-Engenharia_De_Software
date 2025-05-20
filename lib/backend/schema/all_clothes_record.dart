import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AllClothesRecord extends FirestoreRecord {
  AllClothesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  bool hasQuantity() => _quantity != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  bool hasCreatedBy() => _createdBy != null;

  // "expiration_date" field.
  DateTime? _expirationDate;
  DateTime? get expirationDate => _expirationDate;
  bool hasExpirationDate() => _expirationDate != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "search_keywords" field.
  List<String>? _searchKeywords;
  List<String> get searchKeywords => _searchKeywords ?? const [];
  bool hasSearchKeywords() => _searchKeywords != null;

  // "brand" field.
  String? _brand;
  String get brand => _brand ?? '';
  bool hasBrand() => _brand != null;

  // "FavouriteClothes" field.
  List<DocumentReference>? _favouriteClothes;
  List<DocumentReference> get favouriteClothes => _favouriteClothes ?? const [];
  bool hasFavouriteClothes() => _favouriteClothes != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _price = castToType<double>(snapshotData['price']);
    _quantity = castToType<int>(snapshotData['quantity']);
    _createdBy = snapshotData['created_by'] as String?;
    _expirationDate = snapshotData['expiration_date'] as DateTime?;
    _image = snapshotData['image'] as String?;
    _searchKeywords = getDataList(snapshotData['search_keywords']);
    _brand = snapshotData['brand'] as String?;
    _favouriteClothes = getDataList(snapshotData['FavouriteClothes']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('All_Clothes');

  static Stream<AllClothesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AllClothesRecord.fromSnapshot(s));

  static Future<AllClothesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AllClothesRecord.fromSnapshot(s));

  static AllClothesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AllClothesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AllClothesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AllClothesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AllClothesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AllClothesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAllClothesRecordData({
  String? name,
  double? price,
  int? quantity,
  String? createdBy,
  DateTime? expirationDate,
  String? image,
  String? brand,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'price': price,
      'quantity': quantity,
      'created_by': createdBy,
      'expiration_date': expirationDate,
      'image': image,
      'brand': brand,
    }.withoutNulls,
  );

  return firestoreData;
}

class AllClothesRecordDocumentEquality implements Equality<AllClothesRecord> {
  const AllClothesRecordDocumentEquality();

  @override
  bool equals(AllClothesRecord? e1, AllClothesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.price == e2?.price &&
        e1?.quantity == e2?.quantity &&
        e1?.createdBy == e2?.createdBy &&
        e1?.expirationDate == e2?.expirationDate &&
        e1?.image == e2?.image &&
        listEquality.equals(e1?.searchKeywords, e2?.searchKeywords) &&
        e1?.brand == e2?.brand &&
        listEquality.equals(e1?.favouriteClothes, e2?.favouriteClothes);
  }

  @override
  int hash(AllClothesRecord? e) => const ListEquality().hash([
        e?.name,
        e?.price,
        e?.quantity,
        e?.createdBy,
        e?.expirationDate,
        e?.image,
        e?.searchKeywords,
        e?.brand,
        e?.favouriteClothes
      ]);

  @override
  bool isValidKey(Object? o) => o is AllClothesRecord;
}
