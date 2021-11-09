import 'dart:collection';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:queromaisvegano/app/helpers/const.dart';
import 'package:queromaisvegano/app/models/credit_card.dart';
import 'package:queromaisvegano/app/models/user.dart';

class CieloPayment {
  final FirebaseFunctions functions = FirebaseFunctions.instance;

  Future<String?> authorize({
    CreditCard? creditCard,
    num? price,
    String? orderId,
    Usuario? user,
  }) async {
    try {
      final Map<String, dynamic> dataSale = {
        'merchantOrderId': orderId,
        'amount': (price! * 100).toInt(),
        'softDescriptor': storeName,
        'installments': 1,
        'creditCard': creditCard!.toJson(),
        'cpf': user!.cpf,
        'paymentType': 'CreditCard',
      };
      final HttpsCallable callable =
          functions.httpsCallable('authorizeCreditCard');
      final response = await callable.call(dataSale);
      final data = Map<String, dynamic>.from(response.data as LinkedHashMap);

      if (data['success'] as bool) {
        return data['paymentId'] as String;
      } else {
        debugPrint('${data['error']['message']}');
        return Future.error(data['error']['message']);
      }
    } catch (e) {
      debugPrint('$e');
      return Future.error('Falha ao processar transação. Tente novamente');
    }
  }

  Future<void> capture(String payId) async {
    final Map<String, dynamic> captureData = {
      'payId': payId,
    };
    final HttpsCallable callable = functions.httpsCallable('captureCreditCard');
    //TODO: COLOCAR TIMEOUT
    //callable().timeout(Duration(seconds: 60));
    final response = await callable.call(captureData);
    final data = Map<String, dynamic>.from(response.data as LinkedHashMap);
    if (data['success'] as bool) {
      debugPrint('Captura realizada com sucesso.');
    } else {
      debugPrint('${data['error']['message']}');
      return Future.error(data['error']['message']);
    }
  }

  Future<void> cancel(String payId) async {
    final Map<String, dynamic> cancelData = {
      'payId': payId,
    };
    final HttpsCallable callable = functions.httpsCallable('cancelCreditCard');
    final response = await callable.call(cancelData);
    final data = Map<String, dynamic>.from(response.data as LinkedHashMap);
    if (data['success'] as bool) {
      debugPrint('Cancelamento realizado com sucesso.');
    } else {
      debugPrint('${data['error']['message']}');
      return Future.error(data['error']['message']);
    }
  }
}
