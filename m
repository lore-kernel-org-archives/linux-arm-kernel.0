From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 11 Sep 2013 10:34:08 +0200
Subject: [PATCH 0/3] socfpga: dts: cleanups
Message-ID: <1378888451-28096-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This series moves the cyclone5 specific DT stuff to a "new" dtsi file,
and adds a dts for the socfpga_cyclone5_socdk aka the previous socfpga_cyclone5.
This is in preparation for other cyclone5 based boards (e.g. SoCkit or Socrates)

Also, fix the clock names in the socfpga.dtsi and cleanup the indentation.

Regards,
Steffen


Steffen Trumtrar (3):
  ARM: socfpga: dts: Move common nodes to cyclone5 dtsi
  ARM: socfpga: dts: cleanup indentation
  ARM: socfpga: dts: fix s2f_* clock name

 arch/arm/boot/dts/Makefile                         |   2 +-
 arch/arm/boot/dts/socfpga.dtsi                     | 296 ++++++++++-----------
 ...{socfpga_cyclone5.dts => socfpga_cyclone5.dtsi} |  20 --
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       |  40 +++
 4 files changed, 189 insertions(+), 169 deletions(-)
 rename arch/arm/boot/dts/{socfpga_cyclone5.dts => socfpga_cyclone5.dtsi} (78%)
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts

-- 
1.8.4.rc3
