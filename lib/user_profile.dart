import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram/constants.dart';
import 'package:instagram/pictures_in_grid.dart';
import 'package:instagram/setting_card.dart';
import 'package:instagram/sign_in.dart';
import 'package:instagram/story.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Map<int, List<Color>> colors = <int, List<Color>>{
    0: [bgColor == Colors.white ? Colors.black : Colors.white, bgColor],
    1: [bgColor == Colors.white ? Colors.black : Colors.white, bgColor],
    2: [bgColor == Colors.white ? Colors.black : Colors.white, bgColor],
    3: [bgColor == Colors.white ? Colors.black : Colors.white, bgColor],
  };
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            onPressed: () {
              FirebaseAuth.instance.signOut().then(
                    (value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const SignIn(),
                      ),
                    ),
                  );
            },
            icon: Icon(
              Icons.exit_to_app,
              size: 15,
              color: bgColor == Colors.white ? Colors.black : Colors.white,
            ),
          ),
        ],
        backgroundColor: bgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic>? data = snapshot.data!.data();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 41,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.pinkAccent,
                          backgroundImage: CachedNetworkImageProvider(
                            data!["profile_picture_url"],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            data["posts_list"].length.toString(),
                            style: GoogleFonts.abel(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: bgColor == Colors.white
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          Text(
                            "Posts",
                            style: GoogleFonts.abel(
                              fontSize: 16,
                              color: bgColor == Colors.white
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            data["followers_list"].length.toString(),
                            style: GoogleFonts.abel(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: bgColor == Colors.white
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          Text(
                            "Followers",
                            style: GoogleFonts.abel(
                              fontSize: 16,
                              color: bgColor == Colors.white
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            data["following_list"].length.toString(),
                            style: GoogleFonts.abel(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: bgColor == Colors.white
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          Text(
                            "Following",
                            style: GoogleFonts.abel(
                              fontSize: 16,
                              color: bgColor == Colors.white
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data["username"],
                    style: GoogleFonts.abel(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          bgColor == Colors.white ? Colors.black : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data["about"].isEmpty
                        ? "This account has no description"
                        : data["about"],
                    style: GoogleFonts.abel(
                      fontSize: 16,
                      color:
                          bgColor == Colors.white ? Colors.black : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () {},
                    child: Text(
                      "help.instagram.com",
                      style: GoogleFonts.abel(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: Center(
                              child: Text(
                                "Promote",
                                style: GoogleFonts.abel(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 227, 243, 255),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 30,
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                enableDrag: true,
                                isDismissible: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 400,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: bgColor,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: SingleChildScrollView(
                                        child: SettingsUI(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Center(
                              child: Text(
                                "Edit Profile",
                                style: GoogleFonts.abel(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  !data["stories_list"].isEmpty
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              for (Map<String, dynamic> element
                                  in data["stories_list"])
                                const Story()
                            ],
                          ),
                        )
                      : Text(
                          "No Stories",
                          style: GoogleFonts.abel(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: bgColor == Colors.white
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: Colors.grey,
                    indent: 5,
                    endIndent: 5,
                    thickness: 1,
                    height: 1,
                  ),
                  const SizedBox(height: 10),
                  StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setS) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            onPressed: () {
                              setS(() {
                                colors[0] = [Colors.blue, Colors.blue];
                                for (int i = 1; i < 4; i++) {
                                  colors[i] = [
                                    bgColor == Colors.white
                                        ? Colors.black
                                        : Colors.white,
                                    bgColor
                                  ];
                                }
                              });
                            },
                            icon: Column(
                              children: [
                                Icon(
                                  Icons.grid_3x3_outlined,
                                  color: colors[0]![0],
                                  size: 25,
                                ),
                                const SizedBox(height: 2),
                                Container(height: 1, color: colors[0]![1]),
                              ],
                            ),
                          ),
                          IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            onPressed: () {
                              setS(() {
                                colors[1] = [Colors.blue, Colors.blue];
                                for (int i = 0; i < 4; i++) {
                                  if (i != 1) {
                                    colors[i] = [
                                      bgColor == Colors.white
                                          ? Colors.black
                                          : Colors.white,
                                      bgColor
                                    ];
                                  }
                                }
                              });
                            },
                            icon: Column(
                              children: [
                                Icon(
                                  Icons.tv,
                                  color: colors[1]![0],
                                  size: 25,
                                ),
                                const SizedBox(height: 2),
                                Container(height: 1, color: colors[1]![1]),
                              ],
                            ),
                          ),
                          IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            onPressed: () {
                              setS(() {
                                colors[2] = [Colors.blue, Colors.blue];
                                for (int i = 0; i < 4; i++) {
                                  if (i != 2) {
                                    colors[i] = [
                                      bgColor == Colors.white
                                          ? Colors.black
                                          : Colors.white,
                                      bgColor
                                    ];
                                  }
                                }
                              });
                            },
                            icon: Column(
                              children: [
                                Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: colors[2]![0],
                                  size: 25,
                                ),
                                const SizedBox(height: 2),
                                Container(height: 1, color: colors[2]![1]),
                              ],
                            ),
                          ),
                          IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            onPressed: () {
                              setS(() {
                                colors[3] = [Colors.blue, Colors.blue];
                                for (int i = 0; i < 4; i++) {
                                  if (i != 3) {
                                    colors[i] = [
                                      bgColor == Colors.white
                                          ? Colors.black
                                          : Colors.white,
                                      bgColor
                                    ];
                                  }
                                }
                              });
                            },
                            icon: Column(
                              children: [
                                Icon(
                                  FontAwesomeIcons.userAstronaut,
                                  color: colors[3]![0],
                                  size: 25,
                                ),
                                const SizedBox(height: 2),
                                Container(height: 1, color: colors[3]![1]),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      children: <Widget>[
                        PicturesInGrid(
                          uid: data["uid"],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            } else {
              Fluttertoast.showToast(msg: snapshot.error.toString());
              return Container();
            }
          },
        ),
      ),
    );
  }
}
