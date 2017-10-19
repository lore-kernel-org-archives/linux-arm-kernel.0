From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 19 Oct 2017 14:01:40 +0200
Subject: [PATCH 2/5] ARM64: meson: enable MESON_IRQ_GPIO in Kconfig
In-Reply-To: <20171019120143.20581-1-jbrunet@baylibre.com>
References: <20171019120143.20581-1-jbrunet@baylibre.com>
Message-ID: <20171019120143.20581-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

select MESON_IRQ_GPIO in Kconfig for Amlogic's meson SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6b54ee8c1262..5d5e79e8d556 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -104,6 +104,7 @@ config ARCH_MESON
 	select PINCTRL_MESON
 	select COMMON_CLK_AMLOGIC
 	select COMMON_CLK_GXBB
+	select MESON_IRQ_GPIO
 	help
 	  This enables support for the Amlogic S905 SoCs.
 
-- 
2.13.6
