import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:queromaisvegano/models/address.dart';

class Usuario {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Usuario({this.email, this.password, this.name, this.id});

  Usuario.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    name = doc.get('name');
    email = doc.get('email');
    try {
      cpf = doc.get('cpf');
    } catch (e) {
      cpf = '';
    }
    //cpf = doc['cpf'] as String?;

    Map<String, dynamic> dataMap = doc.data() as Map<String, dynamic>;
    if (dataMap.containsKey('address')) {
      address = Address.fromMap(doc['address'] as Map<String, dynamic>);
    }
  }

  String? id;
  String? name;
  String? email;
  String? cpf;
  String? password;

  String? confirmPassword;

  bool? admin = false;

  Address? address;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('user/$id');

  CollectionReference get cartReference => firestoreRef.collection('cart');

  CollectionReference get tokensReference => firestoreRef.collection('tokens');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      if (address != null) 'address': address!.toMap(),
      if (cpf != null && cpf != '') 'cpf': cpf,
    };
  }

  void setAddress(Address address) {
    this.address = address;
    saveData();
  }

  void setCpf(String? cpf) {
    this.cpf = cpf;
    saveData();
  }

  Future<void> saveToken() async {
    final token = await messaging.getToken();
    tokensReference.doc(token).set({
      'token': token,
      'updateAt': FieldValue.serverTimestamp(),
      'platform': Platform.operatingSystem,
    });
  }
}
