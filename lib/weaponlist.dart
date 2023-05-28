
import 'package:coba/weapon_detail.dart';
import 'package:flutter/material.dart';
import 'base_network.dart';

class WeaponList extends StatefulWidget {
  @override
  _WeaponListState createState() => _WeaponListState();
}

class _WeaponListState extends State<WeaponList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weapon List'),
      ),
      body: Container(
        child: FutureBuilder(
          future: BaseNetwork().getWeapon(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null){
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (!snapshot.hasData){
              return Container(
                child: Center(
                  child: Text('Data tidak ditemukan'),
                ),
              );
            } else{
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context)=> WeaponDetail(name: snapshot.data[index])));},
                      leading: Container(
                        height: MediaQuery.of(context).size.height/2.4,
                        child: Image.network(
                            'https://api.genshin.dev/weapons/${snapshot.data[index]}/icon',
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),),
                      ),
                      title: Text(snapshot.data[index].toUpperCase()),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
