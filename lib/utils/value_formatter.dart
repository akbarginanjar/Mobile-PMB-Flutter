import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

String toCurrency(int price, {String? locale, String? symbol}) {
  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: locale ?? 'id',
    symbol: symbol ?? 'Rp ',
    decimalDigits: 0,
  );
  return currencyFormatter.format(price);
}

void copyToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      elevation: 0,
      content: Row(
        children: [
          Icon(Icons.copy, size: 14, color: Colors.white),
          SizedBox(width: 6),
          Text('Berhasil disalin'),
        ],
      ),
    ),
  );
}
