import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:queromaisvegano/app/helpers/const.dart';
import 'package:queromaisvegano/app/models/credit_card.dart';
import 'package:queromaisvegano/app/modules/checkout/components/card_text_field.dart';

class CardBack extends StatelessWidget {
  const CardBack({Key? key, required this.cvvFocus, this.creditCard})
      : super(key: key);
  final FocusNode cvvFocus;
  final CreditCard? creditCard;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 16,
      child: Container(
        height: 200,
        color: kMainColorDark,
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: 40,
              margin: const EdgeInsets.symmetric(
                vertical: 16,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 70,
                  child: Container(
                    margin: const EdgeInsets.only(left: 12),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    color: Colors.grey[500],
                    child: CardTextField(
                      initialValue: creditCard!.securityCode,
                      hint: '123',
                      maxLength: 3,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.end,
                      textInputType: TextInputType.number,
                      validator: (cvv) {
                        if (cvv!.length != 3) {
                          return 'Inválido';
                        }
                        return null;
                      },
                      focusNode: cvvFocus,
                      onSaved: creditCard!.setCVV,
                    ),
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: Container(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
