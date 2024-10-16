import 'package:flutter/material.dart';
import 'package:movlib/consts/colors.dart';
import 'package:movlib/view/configuration/configuration_view.dart';
import 'package:movlib/view/home/home_view_model.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<HomeViewModel>(
      builder: (context, homeVM, child) {
        return ListView(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: KDarker,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.01),
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: size.height * 0.1,
                      backgroundImage:
                          NetworkImage(homeVM.currentUser.imageUrl),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Nome de exibição: ${homeVM.currentUser.displayName}'),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child:
                              Text('Tag de usuário: ${homeVM.currentUser.tag}'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('${homeVM.currentUser.followers ?? 0} Seguidores'),
                      Text('${homeVM.currentUser.following ?? 0} Seguindo'),
                    ],
                  ),
                  SizedBox(height: size.height * 0.01),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            ConfigItem(text: 'Editar Dados do Perfil'),
            ConfigItem(text: 'Mudar Senha'),
            ConfigItem(text: 'Estatisticas'),
            ConfigItem(text: 'Convidar Amigos'),
            SizedBox(height: size.height * 0.06),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: KWhite,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      child: Center(
                        child: Text(
                          'Desconectar',
                          style: TextStyle(
                            color: KDark,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
