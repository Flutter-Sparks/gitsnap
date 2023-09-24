import 'dart:ui';

import 'package:card_animation_gyro/models/profile.dart';
import 'package:card_animation_gyro/models/repo.dart';

import 'package:card_animation_gyro/pages/preview_page.dart';
import 'package:card_animation_gyro/pages/widgets/profile_card.dart';
import 'package:card_animation_gyro/pages/widgets/repo_card.dart';
import 'package:card_animation_gyro/providers/data_provider.dart';
import 'package:card_animation_gyro/res/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool generatingProfileCard = false;
  bool generatingRepoCard = false;

  late TextEditingController userNameCTRL;
  late TextEditingController repoNameCTRL;

  @override
  void initState() {
    userNameCTRL = TextEditingController();
    repoNameCTRL = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameCTRL.dispose();
    repoNameCTRL.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/${context.watch<UserDataProvider>().selectedBackground}',
              ),
              fit: BoxFit.cover),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    profile(context, userNameCTRL),
                    const SizedBox(height: 40),
                    repo(context, userNameCTRL, repoNameCTRL),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profile(BuildContext context, TextEditingController usernameCTRL) {
    return Wrap(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      const Color.fromARGB(255, 130, 130, 130).withOpacity(0.2),
                ),
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter your GitHub username:',
                    style: GoogleFonts.inconsolata().copyWith(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  TextField(
                    controller: usernameCTRL,
                    style: GoogleFonts.inconsolata().copyWith(
                        color: Colors.white.withOpacity(0.5), fontSize: 17),
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.inconsolata().copyWith(
                          color: Colors.white.withOpacity(0.5), fontSize: 17),
                      hintText: 'https://github.com/{username}',
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    color: Colors.white.withOpacity(0.4),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        generatingProfileCard = true;
                      });
                      Profile? profile = await context
                          .read<UserDataProvider>()
                          .getProfile(usernameCTRL.text);
                      setState(() {
                        generatingProfileCard = false;
                      });
                      if (profile != null && mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PreviewPage(
                              card: ProfileCard(profile: profile),
                            ),
                          ),
                        );
                        return;
                      }
                      AppConstants.showToast("Couldn't fetch profile data");
                    },
                    child: generatingProfileCard
                        ? const CupertinoActivityIndicator(
                            color: Colors.white,
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'GENERATE PROFILE CARD'.toUpperCase(),
                                style: GoogleFonts.inconsolata().copyWith(
                                    color: Colors.white,
                                    fontSize: 15,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.arrow_forward_outlined,
                                color: Colors.white,
                                size: 19,
                              )
                            ],
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Wrap repo(BuildContext context, TextEditingController userNameCTRL,
      TextEditingController repoNameCTRL) {
    return Wrap(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              // height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      const Color.fromARGB(255, 130, 130, 130).withOpacity(0.2),
                ),
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter your GitHub Repo name:',
                    style: GoogleFonts.inconsolata().copyWith(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: TextField(
                          controller: userNameCTRL,
                          style: GoogleFonts.inconsolata().copyWith(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 17),
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.inconsolata().copyWith(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 17),
                            hintText: '{username}/',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: repoNameCTRL,
                          style: GoogleFonts.inconsolata().copyWith(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 17),
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.inconsolata().copyWith(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 17),
                            hintText: '{repo_name}',
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    color: Colors.white.withOpacity(0.4),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        generatingRepoCard = true;
                      });
                      Repository? repo = await context
                          .read<UserDataProvider>()
                          .getRepository(userNameCTRL.text, repoNameCTRL.text);
                      setState(() {
                        generatingRepoCard = false;
                      });
                      if (repo != null && mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PreviewPage(
                              card: RepoCard(repository: repo),
                            ),
                          ),
                        );
                        return;
                      }
                      AppConstants.showToast("Couldn't fetch repo data");
                    },
                    child: generatingRepoCard
                        ? const CupertinoActivityIndicator(
                            color: Colors.white,
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'GENERATE REPO CARD'.toUpperCase(),
                                style: GoogleFonts.inconsolata().copyWith(
                                    color: Colors.white,
                                    fontSize: 15,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.arrow_forward_outlined,
                                color: Colors.white,
                                size: 19,
                              )
                            ],
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
