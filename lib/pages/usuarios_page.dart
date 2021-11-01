import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final usuarios = [
    Usuario(
        online: true,
        email: 'geroblanco13@gmail.com',
        nombre: 'Geronimo',
        uid: '1'),
    Usuario(
        online: true,
        email: 'geroblancobv@gmail.com',
        nombre: 'Manuel',
        uid: '2'),
    Usuario(
        online: false, email: 'alejobk@hotmail.com', nombre: 'Alejo', uid: '3'),
    Usuario(
        online: true,
        email: 'bautista12344@gmail.com',
        nombre: 'Bautista',
        uid: '4'),
    Usuario(
        online: false,
        email: 'ianKombolitis12@gmail.com',
        nombre: 'Ian',
        uid: '5'),
    Usuario(
        online: true, email: 'maxikombo@gmail.com', nombre: 'Maxi', uid: '6'),
    Usuario(
        online: false,
        email: 'valentinhotm@gmail.com',
        nombre: 'Valentin',
        uid: '7'),
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            usuario?.nombre ?? 'Sin nombre',
            style: TextStyle(color: Colors.black54),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black54,
            ),
            onPressed: () {
              // TODO: Desconectarnos del socket server
              AuthService.deleteToken();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              // child: Icon(Icons.check_circle, color: Colors.blue),
              child: Icon(Icons.offline_bolt, color: Colors.red),
            )
          ],
        ),
        body: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            onRefresh: _cargarUsuarios,
            header: WaterDropHeader(
                complete: Icon(Icons.check, color: Colors.blue[400]),
                waterDropColor: Colors.blue),
            child: _listViewUsuarios()));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuarios.length);
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
