import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:intl/intl.dart';
import 'package:pinterest_clone/home_screen.dart';
import 'package:pinterest_clone/widgets/rectangular_button.dart';

class OwnerDetails extends StatefulWidget {
  String img;
  String userImg;
  String name;
  DateTime date;
  String docId;
  String userId;
  int downloads;

  OwnerDetails(
      {super.key,
      required this.img,
      required this.userImg,
      required this.name,
      required this.date,
      required this.docId,
      required this.downloads,
      required this.userId});

  @override
  _OwnerDetailsState createState() => _OwnerDetailsState();
}

class _OwnerDetailsState extends State<OwnerDetails> {
  int? total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.red,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              iconSize: 22,
                              tooltip: 'Home',
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const HomeScreen()));
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Image.network(
                          widget.img,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'User Data',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(widget.userImg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Posted by:${widget.name}',
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  DateFormat('dd MMMM yyyy - hh:mm a')
                      .format(widget.date)
                      .toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.download_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                    Text(
                      ' ${widget.downloads}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: RectangularButton(
                    text: 'Download',
                    colors1: Colors.green,
                    colors2: Colors.lightGreen,
                    press: () async {
                      try {
                        var imageId =
                            await ImageDownloader.downloadImage(widget.img);
                        if (imageId == null) {
                          return;
                        }
                        Fluttertoast.showToast(msg: 'Image saved in Gallery');
                        total = widget.downloads + 1;

                        FirebaseFirestore.instance
                            .collection('wallpaper')
                            .doc(widget.docId)
                            .update({
                          'downloads': total,
                        }).then((value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomeScreen()),
                          );
                        });
                      } on PlatformException catch (error) {
                        print(error);
                      }
                    },
                  ),
                ),
                FirebaseAuth.instance.currentUser!.uid == widget.userId
                    ? Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: RectangularButton(
                          text: 'Delete',
                          colors1: Colors.green,
                          colors2: Colors.lightGreen,
                          press: () async {
                            FirebaseFirestore.instance
                                .collection('wallpaper')
                                .doc(widget.docId)
                                .delete()
                                .then((value) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomeScreen(),
                                ),
                              );
                            });
                          },
                        ),
                      )
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
