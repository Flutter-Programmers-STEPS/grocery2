import 'package:flutter/material.dart';
import 'package:grocery_app/screens/authentication/google_auth.dart';
import 'package:grocery_app/screens/login/login_page.dart';

import '../searchbar/itemsearch_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController();
  int _currentIndex = 0;
  List<String> offerPercentage = ['10%', '30%', '50%'];
  List<String> offerImage = [
    'assets/bag-1.jpg',
    'assets/bag-2.jpg',
    'assets/bag-3.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.account_circle))
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            SearchBar(onTextChange: (String ) {  },),

          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 120,
                    backgroundImage: NetworkImage(imageUrl!),
                  )),
            ),
            ListTile(
              title: Text("$name"),
              subtitle: Text("$email"),
            ),
            Column(
              children: [
                ListTile(
                  title: Text("My Account"),
                ),
                ListTile(
                  title: Text("Orders"),
                ),
                ListTile(
                  title: Text("Payments"),
                ),
                ListTile(
                  title: Text("Ratings & Reviews"),
                ),
                ListTile(
                  title: Text("Notifications"),
                ),
                ListTile(
                  title: Text("Delivery Address"),
                ),
                ListTile(
                  title: Text("Logout"),
                  onTap: () {
                    signOutGoogle();
                    Navigator.of(context)
                        .pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            LoginPage(),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
