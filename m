From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 27 Jul 2014 14:22:02 +0200
Subject: [PATCH 0/3] ARM: EXYNOS: Fix Exynos5410 boot
Message-ID: <1406463725-4208-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This mini-series unbreaks booting on 5410 based ODROID-XU.

Since I do not have access to a TRM, the address is a guess based on 
5250 and 5410. Such a node was not present in the 3.14 downstream tree.

Regards,
Andreas

Andreas F?rber (3):
  Documentation: devicetree: Document exynos5410 PMU
  ARM: dts: exynos: Add PMU to Exynos5410
  ARM: EXYNOS: Add support for Exynos5410 PMU

 Documentation/devicetree/bindings/arm/samsung/pmu.txt | 1 +
 arch/arm/boot/dts/exynos5410.dtsi                     | 5 +++++
 arch/arm/mach-exynos/exynos.c                         | 1 +
 3 files changed, 7 insertions(+)

-- 
1.9.3
