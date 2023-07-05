import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isShowUsers = false;
  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Search for a user',
            ),
            controller: _searchController,
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUsers = true;
              });
            },
          ),
        ),
        body: isShowUsers
        ? FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .where('username',
                    isGreaterThanOrEqualTo: _searchController.text)
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          (snapshot.data! as dynamic).docs[index]
                              ['photoUrl'],
                        ),
                      ),
                      title: Text(
                        (snapshot.data! as dynamic).docs[index]['username'],
                      ),
                    );
                  });
            })
        : FutureBuilder(
            future: FirebaseFirestore.instance.collection('posts').get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return StaggeredGrid.count(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: List.generate(
                    (snapshot.data! as dynamic).docs.length, (index) {
                  return StaggeredGridTile.count(
                    crossAxisCellCount: (index % 7 == 0) ? 2 : 1,
                    mainAxisCellCount: (index % 7 == 0) ? 2 : 1,
                    child: Image.network(
                      (snapshot.data! as dynamic).docs[index]['postUrl'],
                      fit: BoxFit.cover,
                    ),
                  );
                }),
              );
            }
          )
        );
  }
}