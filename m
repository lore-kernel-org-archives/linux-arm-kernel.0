From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 19 Oct 2017 14:01:39 +0200
Subject: [PATCH 1/5] ARM: meson: enable MESON_IRQ_GPIO in Kconfig for meson8b
In-Reply-To: <20171019120143.20581-1-jbrunet@baylibre.com>
References: <20171019120143.20581-1-jbrunet@baylibre.com>
Message-ID: <20171019120143.20581-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

select MESON_IRQ_GPIO in Kconfig for Amlogic's meson8b SoC

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm/mach-meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index ee30511849ca..dc4830bb80fc 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -28,5 +28,6 @@ config MACH_MESON8B
 	default ARCH_MESON
 	select MESON6_TIMER
 	select COMMON_CLK_MESON8B
+	select MESON_IRQ_GPIO
 
 endif
-- 
2.13.6
