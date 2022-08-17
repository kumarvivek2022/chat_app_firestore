import 'package:flutter/material.dart';

class CustomDefaultAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.topLeft,
            colors: [
              Color.fromARGB(225,157,112,229),
              Colors.blue,
            ])

      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: ()  {},
              icon: const Icon(Icons.menu,color: Colors.white,size: 30,)),
           Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text("name",style: const TextStyle(fontSize: 25,color: Colors.white),),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search,color: Colors.white,size: 30,))
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100);
}
