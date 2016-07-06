From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  6 Jul 2016 17:10:41 +0800
Subject: [PATCH 0/9] ARM: dts: sun7i: BPI-M1+ and Lamobo-R1 fixes
Message-ID: <1467796250-22010-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

These are a bunch of fixes I did to get my boards running. Some of them
are cleanups, while others enable hardware that we already support on
other boards, such as USB or the audio codec.

Regards
ChenYu

Chen-Yu Tsai (9):
  ARM: dts: sun7i: lamobo-r1: Fix USB-based WiFi module power
  ARM: dts: sun7i: lamobo-r1: Remove usb1 vbus regulator
  ARM: dts: sun7i: lamobo-r1: Fix GPIO flags in reg_ahci_5v
  ARM: dts: sun7i: lamobo-r1: Enable audio codec
  ARM: dts: sun7i: bananapi-m1-plus: Reindent whole file using tabs
  ARM: dts: sun7i: bananapi-m1-plus: Unify suffix for board specific
    labels
  ARM: dts: sun7i: bananapi-m1-plus: red LED is power LED
  ARM: dts: sun7i: bananapi-m1-plus: Add PMIC regulators and OPPs for
    cpufreq
  ARM: dts: sun7i: bananapi-m1-plus: Enable USB OTG

 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts | 342 ++++++++++++++---------
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts        |  20 +-
 2 files changed, 218 insertions(+), 144 deletions(-)

-- 
2.8.1
