import 'package:coba/charadetail.dart';
import 'package:coba/karakterlist.dart';
import 'package:coba/weapon_detail.dart';
import 'package:coba/weaponlist.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? lastSeen;
  String? id;

  Future<void> getLastSeen() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState((){
      lastSeen = pref.getString("last_seen");
      id = pref.getString('id');
    });
  }

  @override
  void initState() {
    super.initState();
    lastSeen = "";
    id = "";
    getLastSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://4.bp.blogspot.com/-iz7Z_jLPL6E/XQ8eHVZTlnI/AAAAAAAAHtA/rDn9sYH174ovD4rbxsC8RSBeanFvfy75QCKgBGAs/w1440-h2560-c/genshin-impact-characters-uhdpaper.com-4K-2.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.srcOver,
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo1.png'),
            if (lastSeen != null && lastSeen != "")
                  Container(
              padding: EdgeInsets.symmetric(horizontal: 120, vertical: 10),
              child: Card(
                child: ListTile(
                  onTap: () async {
                    if (id == "characters") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CharacterDetail(name: lastSeen!),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeaponDetail(
                              name: lastSeen!,
                            ),
                          ));
                    }
                  },
                  leading: Image.network(
                      'https://api.genshin.dev/${id}/${lastSeen!.toLowerCase()}/icon'),
                  title: Text(lastSeen.toString().toUpperCase()),
                ),
              ),
                  ),

              SizedBox(height: 50,),
              Container(
                width: 120,
                height: 35,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(

                  ),
                    onPressed: () async { await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CharacterList()));
                    getLastSeen();},
                    child: Text('Karakter')),
              ),
              SizedBox(height: 20,),
              Container(
                width: 120,
                height: 35,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(

                    ),
                    onPressed: () async { await Navigator.of(context).push(MaterialPageRoute(builder: (context) => WeaponList()));
                      getLastSeen();},
                    child: Text('Weapon')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
