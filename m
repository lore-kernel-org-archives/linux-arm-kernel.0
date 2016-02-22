From: nm@ti.com (Nishanth Menon)
Date: Mon, 22 Feb 2016 10:51:06 -0600
Subject: [PATCH 0/2] ARM: OMAP: X15: Add support for eeprom
Message-ID: <1456159868-32416-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


X15 and BB family of boards use AT24 compatible eeproms

Enable support for the same.

Nishanth Menon (2):
  ARM: dts: am57xx-beagle-x15: Add eeprom information
  ARM: omap2plus_defconfig: Enable AT24 eeprom

 arch/arm/boot/dts/am57xx-beagle-x15.dts | 5 +++++
 arch/arm/configs/omap2plus_defconfig    | 1 +
 2 files changed, 6 insertions(+)

-- 
2.7.0
