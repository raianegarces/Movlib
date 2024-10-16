import 'package:flutter/material.dart';
import 'package:movlib/consts/colors.dart';

class ConfigurationView extends StatelessWidget {
  static const route = 'configuration_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 16),
            ConfigItem(text: 'Notificações'),
            ConfigItem(text: 'Ajuda'),
            ConfigItem(text: 'Sobre'),
            ConfigItem(text: 'Tema'),
            ConfigItem(text: 'Privacidade'),
          ],
        ),
      ),
    );
  }
}

class ConfigItem extends StatelessWidget {
  const ConfigItem({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: KWhiter,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: KWhiter,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: const Divider(
            color: KWhite,
            thickness: 3,
          ),
        )
      ],
    );
  }
}
