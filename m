From: rjui@broadcom.com (Ray Jui)
Date: Thu, 17 Sep 2015 16:57:58 -0700
Subject: [PATCH 0/4] Broadcom Cygnus device tree changes
Message-ID: <1442534282-21356-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series cleans up the Broadcom Cygnus device tree files and makes it
more consistent with the rest of Broadcom iProc device tree files. This patch
series also enables various peripherals on Cygnus boards. They include:

bcm11360_entphn:
NAND

bcm958300k:
touchscreen

bcm958305k:
I2C, PCIe, NAND, touchscreen

Code is based on v4.3-rc1 and is available on GITHUB:
https://github.com/Broadcom/cygnus-linux/tree/cygnus-dt-v1

Ray Jui (4):
  ARM: dts: clean up Cygnus DT files
  ARM: dts: Enable various peripherals on bcm958305k
  ARM: dts: Enable NAND support on bcm911360_entphn
  ARM: dts: enable touchscreen support on Cygnus

 arch/arm/boot/dts/bcm-cygnus.dtsi      | 337 +++++++++++++++++----------------
 arch/arm/boot/dts/bcm911360_entphn.dts |  28 ++-
 arch/arm/boot/dts/bcm911360k.dts       |  10 +-
 arch/arm/boot/dts/bcm958300k.dts       |  45 ++---
 arch/arm/boot/dts/bcm958305k.dts       |  41 +++-
 5 files changed, 257 insertions(+), 204 deletions(-)

-- 
1.9.1
