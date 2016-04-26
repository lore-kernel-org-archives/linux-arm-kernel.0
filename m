From: yegorslists@googlemail.com (yegorslists at googlemail.com)
Date: Tue, 26 Apr 2016 15:00:23 +0200
Subject: [PATCH 0/3] Add additional OnRISC Baltos devices
Message-ID: <1461675626-5818-1-git-send-email-yegorslists@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yegor Yefremov <yegorslists@googlemail.com>

This series splits am335x-baltos.dtsi out of am335x-baltos-ir5221.dts to
consolidate common configuration for Baltos device.

DTS files for Baltos IR3220 and IR2110 will be added using newly created
am335x-baltos.dtsi.

Yegor Yefremov (3):
  ARM: dts: split am335x-baltos-ir5221 into dts and dtsi files
  ARM: dts: add DTS for Baltos IR3220
  ARM: dts: add DTS for Baltos IR2110

 arch/arm/boot/dts/Makefile                 |   2 +
 arch/arm/boot/dts/am335x-baltos-ir2110.dts |  71 +++++
 arch/arm/boot/dts/am335x-baltos-ir3220.dts | 119 +++++++++
 arch/arm/boot/dts/am335x-baltos-ir5221.dts | 387 +--------------------------
 arch/arm/boot/dts/am335x-baltos.dtsi       | 408 +++++++++++++++++++++++++++++
 5 files changed, 601 insertions(+), 386 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-baltos-ir2110.dts
 create mode 100644 arch/arm/boot/dts/am335x-baltos-ir3220.dts
 create mode 100644 arch/arm/boot/dts/am335x-baltos.dtsi

-- 
2.1.4
