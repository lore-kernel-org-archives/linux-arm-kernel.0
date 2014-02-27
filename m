From: markus.mayer@linaro.org (Markus Mayer)
Date: Thu, 27 Feb 2014 13:56:03 -0800
Subject: [PATCH 0/3] ARM: bcm21664: Add initial support.
Message-ID: <1393538166-22868-1-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds initial support for the Broadcom BCM21664 mobile SoC.

The series depends on the series "ARM: bcm281xx: Consolidate code":
    https://lkml.org/lkml/2014/2/25/548

Markus Mayer (3):
  ARM: DT: bcm21664: Device tree bindings
  ARM: bcm21664: Add board support.
  ARM: dts: bcm21664: Add device tree files.

 .../devicetree/bindings/arm/bcm/bcm21664.txt       |   15 +
 .../devicetree/bindings/arm/bcm/kona-resetmgr.txt  |   14 +
 arch/arm/boot/dts/Makefile                         |    3 +-
 arch/arm/boot/dts/bcm21664-garnet.dts              |   56 ++++
 arch/arm/boot/dts/bcm21664.dtsi                    |  292 ++++++++++++++++++++
 arch/arm/mach-bcm/Makefile                         |    6 +-
 arch/arm/mach-bcm/board_bcm21664.c                 |   78 ++++++
 7 files changed, 461 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/bcm21664.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/kona-resetmgr.txt
 create mode 100644 arch/arm/boot/dts/bcm21664-garnet.dts
 create mode 100644 arch/arm/boot/dts/bcm21664.dtsi
 create mode 100644 arch/arm/mach-bcm/board_bcm21664.c

-- 
1.7.9.5
