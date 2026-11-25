import 'package:flutter/material.dart';
import 'package:capstone_deriquito/colors.dart';
 
class BookCover extends StatelessWidget {
  const BookCover({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });
 
  final String? imageUrl;
  final double width;
  final double height;
 
  @override
  Widget build(BuildContext context) {
    Widget placeholder = Container(
      width: width,
      height: height,
      color: softGreen,
      child: const Icon(Icons.menu_book, color: bottleGreen),
    );
 
    if (imageUrl == null) {
      return placeholder;
    }
 
    return Image.network(
      imageUrl!,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => placeholder,
    );
  }
}