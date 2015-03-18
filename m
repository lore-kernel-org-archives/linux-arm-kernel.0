From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 18 Mar 2015 11:23:59 +0800
Subject: [PATCH 0/3] ARM: sun8i: Add SMP and arch-timer support for A23
Message-ID: <1426649042-30547-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This series adds support for SMP and arch-timer for the
A23. This follows our discussion from yesterday about
getting arch-timer support for sun8i and sun9i. I will
post a separate patch for sun9i-a80.

I know some people would like to see arch-timer and SMP
supported with PSCI, but work on this has been slow. So
in the mean time, I thought I'd just post what SMP code
I have.

Feel free to just merge the first patch if you think SMP
can wait.


Regards
ChenYu


Chen-Yu Tsai (3):
  ARM: dts: sun8i: Enable ARM architected timer on A23
  ARM: sun8i: Add SMP support for the Allwinner A23
  ARM: sun8i: dt: Enable A23 SMP support

 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/boot/dts/sun8i-a23.dtsi               | 16 ++++++
 arch/arm/mach-sunxi/platsmp.c                  | 69 ++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

-- 
2.1.4
