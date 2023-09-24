import 'dart:ui';

import 'package:card_animation_gyro/res/colors.dart';
import 'package:card_animation_gyro/res/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:card_animation_gyro/models/repo.dart';
import 'package:iconsax/iconsax.dart';

class RepoCard extends StatelessWidget {
  final Repository repository;

  const RepoCard({
    Key? key,
    required this.repository,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.cardBorderColor,
                ),
                color: AppColors.cardBGColor,
                borderRadius: BorderRadius.circular(13),
              ),
              width: 350,
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Iconsax.book_14,
                        color: Colors.white,
                        size: 19,
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: 250,
                        child: Text(
                          "${repository.userName}/${repository.repoName}",
                          style: GoogleFonts.poppins().copyWith(
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    repository.bio,
                    style: GoogleFonts.poppins().copyWith(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundImage: NetworkImage(repository.userPFP),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Created by @${repository.userName}',
                        style: GoogleFonts.poppins().copyWith(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    children: [...repository.tags.map((e) => tag(e))],
                  ),
                  const SizedBox(height: 8),
                  Divider(
                    color: Colors.white.withOpacity(0.3),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      numberColumn(AppConstants.numberFormat(repository.stars),
                          CupertinoIcons.star_fill),
                      numberColumn(AppConstants.numberFormat(repository.forks),
                          Icons.account_tree_outlined),
                      numberColumn(repository.language, Icons.circle),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget tag(String text) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
        child: Text(
          '#$text'.toUpperCase(),
          style: GoogleFonts.poppins().copyWith(
            color: Colors.white.withOpacity(0.8),
            fontSize: 8,
          ),
        ),
      ),
    );
  }

  Widget numberColumn(String number, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white.withOpacity(0.8),
            size: 13,
          ),
          const SizedBox(width: 5),
          Text(
            number.toUpperCase(),
            style: GoogleFonts.poppins().copyWith(
                color: Colors.white.withOpacity(0.8),
                fontSize: 11,
                letterSpacing: 1,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
