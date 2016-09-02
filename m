From: nm@ti.com (Nishanth Menon)
Date: Fri, 2 Sep 2016 04:05:58 -0500
Subject: [PATCH 0/2] ARM: dts: Introduce support for rev BeagleBoard-X15 B1
Message-ID: <20160902090600.27262-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Please find the series to cleanup and support Production version of
Beagleboard-X15 rev B1 support.

More  details can be found at https://github.com/beagleboard/beagleboard-x15

Bootlog on B1: http://pastebin.ubuntu.com/23123408/ (sd and hdmi hpd tested)

Nishanth Menon (2):
  ARM: dts: am57xx-beagle-x15: Remove pinmux configurations
  ARM: dts: am57xx-beagle-x15: Add support for rev B1

 arch/arm/boot/dts/Makefile                         |   1 +
 ...eagle-x15.dts => am57xx-beagle-x15-common.dtsi} | 230 +-----
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts      |  24 +
 arch/arm/boot/dts/am57xx-beagle-x15.dts            | 812 +--------------------
 4 files changed, 34 insertions(+), 1033 deletions(-)
 copy arch/arm/boot/dts/{am57xx-beagle-x15.dts => am57xx-beagle-x15-common.dtsi} (60%)
 create mode 100644 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts

-- 
2.9.1.200.gb1ec08f
