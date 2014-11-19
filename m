From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 19 Nov 2014 16:56:20 +0100
Subject: [PATCH 0/4] ARM: dts: exynos: Second round of Spring support
Message-ID: <1416412585-10809-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Following the initial merge of the HP Chromebook 11 device tree,
here's a few follow-ups. A sound series is prepared separately.

Regards,
Andreas


Andreas F?rber (4):
  ARM: dts: Add usb3503 pinctrl to exynos5250-spring
  ARM: dts: Add temperature sensor to exynos5250-spring
  ARM: exynos_defconfig: Enable LM90 driver
  ARM: dts: Add trackpad to exynos5250-spring

 arch/arm/boot/dts/exynos5250-spring.dts | 30 ++++++++++++++++++++++++++++++
 arch/arm/configs/exynos_defconfig       |  3 ++-
 2 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.1.2
