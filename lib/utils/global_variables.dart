import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  Center(
    child: Text('Home'),
  ),
  Center(
    child: Text('Search'),
  ),
  AddPostScreen(),
  Center(
    child: Text('Favorite'),
  ),
  Center(
    child: Text('Profile'),
  ),
];
