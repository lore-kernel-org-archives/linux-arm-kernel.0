From: markus.mayer@linaro.org (Markus Mayer)
Date: Fri, 28 Jun 2013 13:56:56 -0700
Subject: [PATCH 0/2] ARM: bcm281xx: Board specific reboot code
Message-ID: <1372453018-5830-1-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds reboot code and related device tree bindings needed
for the bcm281xx family.

Markus Mayer (2):
  ARM: bcm281xx: Board specific reboot code
  ARM: bcm281xx: DT changes for reboot code

 .../devicetree/bindings/arm/bcm/bcm,kona-wdt.txt   |   15 ++++++
 arch/arm/boot/dts/bcm11351.dtsi                    |    7 ++-
 arch/arm/mach-bcm/Makefile                         |    4 +-
 arch/arm/mach-bcm/board_bcm.c                      |   20 ++++++--
 arch/arm/mach-bcm/kona.c                           |   54 ++++++++++++++++++++
 arch/arm/mach-bcm/kona.h                           |   15 ++++++
 6 files changed, 109 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/bcm,kona-wdt.txt
 create mode 100644 arch/arm/mach-bcm/kona.c
 create mode 100644 arch/arm/mach-bcm/kona.h

-- 
1.7.9.5
