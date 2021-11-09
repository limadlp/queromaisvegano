import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:queromaisvegano/app/models/credit_card.dart';

import 'card_back.dart';
import 'card_front.dart';

class CreditCardWidget extends StatefulWidget {
  const CreditCardWidget(this.creditCard, {Key? key}) : super(key: key);

  final CreditCard? creditCard;

  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  final FocusNode numberFocus = FocusNode();
  final FocusNode dateFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode cvvFocus = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        keyboardBarColor: Colors.grey[200],
        actions: [
          KeyboardActionsItem(focusNode: numberFocus, displayDoneButton: false),
          KeyboardActionsItem(focusNode: dateFocus, displayDoneButton: false),
          KeyboardActionsItem(focusNode: nameFocus, toolbarButtons: [
            (_) {
              return GestureDetector(
                onTap: () {
                  cardKey.currentState!.toggleCard();
                  cvvFocus.requestFocus();
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text('Virar cartão'),
                ),
              );
            }
          ]),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: KeyboardActions(
        config: _buildConfig(context),
        autoScroll: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FlipCard(
              key: cardKey,
              direction: FlipDirection.HORIZONTAL,
              speed: 700,
              flipOnTouch: false,
              front: CardFront(
                creditCard: widget.creditCard,
                numberFocus: numberFocus,
                dateFocus: dateFocus,
                nameFocus: nameFocus,
                finished: () {
                  cardKey.currentState!.toggleCard();
                  cvvFocus.requestFocus();
                },
              ),
              back: CardBack(
                creditCard: widget.creditCard,
                cvvFocus: cvvFocus,
              ),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {
                cardKey.currentState!.toggleCard();
              },
              textColor: Colors.white,
              padding: EdgeInsets.zero,
              child: const Text('Virar cartão'),
            )
          ],
        ),
      ),
    );
  }
}
