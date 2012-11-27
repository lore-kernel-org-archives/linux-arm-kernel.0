From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 27 Nov 2012 18:30:33 +0530
Subject: [PATCH 0/3] i2c: Add High speed I2C controller driver for Exynos5
Message-ID: <1354021236-28596-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5 and latter SoCs from Samsung supports High Speed I2C controller.
This patch set adds the controller driver, device tree information for Exynos5
platform and defines gating clocks.

Naveen Krishna Chatradhi (3):
  i2c: exynos5: add High Speed I2C controller driver
  ARM: exynos5: Add gate clocks for HS-I2C
  arm: exynos5: Add HS-I2C device tree platform information

 arch/arm/boot/dts/exynos5250-smdk5250.dts |   16 +
 arch/arm/boot/dts/exynos5250.dtsi         |   32 ++
 arch/arm/mach-exynos/clock-exynos5.c      |   20 +
 drivers/i2c/busses/Kconfig                |    6 +
 drivers/i2c/busses/Makefile               |    1 +
 drivers/i2c/busses/i2c-exynos5.c          |  758 +++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-exynos5.h          |   80 +++
 7 files changed, 913 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-exynos5.c
 create mode 100644 drivers/i2c/busses/i2c-exynos5.h

-- 
1.7.9.5
