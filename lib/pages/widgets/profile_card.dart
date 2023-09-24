import 'dart:ui';

import 'package:card_animation_gyro/models/profile.dart';
import 'package:card_animation_gyro/res/colors.dart';
import 'package:card_animation_gyro/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ProfileCard extends StatelessWidget {
  final Profile profile;

  const ProfileCard({super.key, required this.profile});

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
                border: Border.all(color: AppColors.cardBGColor),
                color: AppColors.cardBorderColor,
                borderRadius: BorderRadius.circular(13),
              ),
              width: 300,
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(profile.pfp),
                    backgroundColor: Colors.white.withOpacity(0.1),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    profile.fullName,
                    style: GoogleFonts.poppins().copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Iconsax.building,
                            color: Color(0xFFE0E0E0),
                            size: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            profile.organization,
                            style: GoogleFonts.poppins().copyWith(
                                color: const Color(0xFFE0E0E0),
                                fontSize: 11,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 15,
                          width: 1,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Iconsax.global,
                            color: Color(0xFFE0E0E0),
                            size: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            profile.country,
                            style: GoogleFonts.poppins().copyWith(
                                color: const Color(0xFFE0E0E0),
                                fontSize: 11,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(
                    color: Colors.white.withOpacity(0.3),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      numberColumn(
                          AppConstants.numberFormat(
                            profile.followers,
                          ),
                          'Followers'),
                      numberColumn(
                          AppConstants.numberFormat(
                            profile.following,
                          ),
                          'Following'),
                      numberColumn(
                        profile.repoCount.toString(),
                        'Repositories',
                      ),
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

  Widget numberColumn(String number, String text) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.poppins().copyWith(
              color: Colors.white, fontSize: 19, fontWeight: FontWeight.w600),
        ),
        Text(
          text.toUpperCase(),
          style: GoogleFonts.poppins()
              .copyWith(color: Colors.white.withOpacity(0.7), fontSize: 10),
        ),
      ],
    );
  }
}
