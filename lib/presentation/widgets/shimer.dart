import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget gridShimmer(BuildContext context) {
  return ColoredBox(
    color: Colors.grey.shade100,
    child: GridView.builder(
       padding:
                EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15.w,
            mainAxisExtent: 230.h,
            mainAxisSpacing: 15.h),
        itemBuilder: (context, index) =>
            AnimatedShimmer(width: 200.w, height: 200.h, borderRadius: BorderRadius.circular(10.sp),)),
  );
}
