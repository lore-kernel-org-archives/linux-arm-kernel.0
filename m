From: tobetter@gmail.com (Dongjin Kim)
Date: Tue, 18 Dec 2012 04:55:03 +0900
Subject: [PATCH 0/4] ODROID-X: Adding dt-based ODROID-X support
Message-ID: <1355774107-364-1-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds DT-based board file for Hardkernel's ODROID-X which is
based on Samsung's Exynos4412 SoC. In the current version had been tested
supporting SDCARD, eMMC and LED blinking.


Dongjin Kim (4):
  ODROID-X: dts: Add board dts file for ODROID-X
  ODROID-X: dts: Add fixed-regulator for peripherals.
  ODROID-X: dts: Add nodes for leds based on GPIO.
  ODROID-X: dts: Add mshc node for ODROID-X board

 arch/arm/boot/dts/Makefile               |    1 +
 arch/arm/boot/dts/exynos4412-odroidx.dts |   97 ++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos4412-odroidx.dts

-- 
1.7.9.5
