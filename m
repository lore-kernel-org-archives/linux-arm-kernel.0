From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 27 Sep 2012 15:56:34 +0530
Subject: [PATCH V1 0/2] ARM: Exynos: Enable I2S platform support for Exynos5
Message-ID: <1348741596-29451-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set enables device tree based platform support for the three I2S
controllers on Samsung's Exynos5 SoC's.

Padmavathi Venna (2):
  ARM: dts: Add nodes for i2s controllers for Samsung Exynos5 platforms
  ARM: EXYNOS: Enable platform support for I2S controllers

 arch/arm/boot/dts/exynos5250-smdk5250.dts |   15 +++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi         |   28 ++++++++++++++++++++++++++++
 arch/arm/mach-exynos/mach-exynos5-dt.c    |    6 ++++++
 3 files changed, 49 insertions(+), 0 deletions(-)

-- 
1.7.4.4
