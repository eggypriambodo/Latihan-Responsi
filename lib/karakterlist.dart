import 'package:coba/charadetail.dart';
import 'package:flutter/material.dart';
import 'base_network.dart';

class CharacterList extends StatefulWidget {
  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Character List'),
      ),
      body: Container(
        child: FutureBuilder(
          future: BaseNetwork().getKarakter(),
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
                                  (context)=> CharacterDetail(name: snapshot.data[index])));},
                        leading: Image.network(
                            'https://api.genshin.dev/characters/${snapshot.data[index]}/icon',
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),),
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
