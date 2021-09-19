import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoreService {
  StoreService._privateConstructor();

  static final StoreService _instance = StoreService._privateConstructor();

  factory StoreService() {
    return _instance;
  }
  static String collectionName = "UserPosition";

  Future<DocumentReference<Map<String, dynamic>>> insert(
      Map<String, dynamic> data) {
    return FirebaseFirestore.instance.collection(collectionName).add(data);
  }
}
