import 'package:chatapp/presentation/chatrooms.dart';
import 'package:flutter/material.dart';

class CustomChatInboxAppBar extends StatelessWidget
    implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.topLeft,
              colors: [
                Color.fromARGB(225, 157, 112, 229),
                Colors.blue,
              ])),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 40),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ChatRoom(),
                    ));
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 30,
              ),
            ),
            const CircleAvatar(
              backgroundColor: Color(0xFF8f76e6),
            ),
            const SizedBox(
              width: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 9),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Message",
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Last Seen 8:30 AM",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.videocam_rounded,
                    color: Colors.white,
                    size: 20,
                  )),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.call,
                  color: Colors.white,
                  size: 20,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 20,
                ))
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100);
}
