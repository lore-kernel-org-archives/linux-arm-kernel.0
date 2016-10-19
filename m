From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 19 Oct 2016 17:21:17 +0200
Subject: [PATCH v2 6/9] ARM64: meson: enable MESON_IRQ_GPIO in Kconfig
In-Reply-To: <1476890480-8884-1-git-send-email-jbrunet@baylibre.com>
References: <1476890480-8884-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1476890480-8884-7-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add select MESON_IRQ_GPIO in Kconfig for Amlogic's meson SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index cfbdf02ef566..846479d4492d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -95,6 +95,7 @@ config ARCH_MESON
 	select PINCTRL_MESON
 	select COMMON_CLK_AMLOGIC
 	select COMMON_CLK_GXBB
+	select MESON_GPIO_IRQ
 	help
 	  This enables support for the Amlogic S905 SoCs.
 
-- 
2.7.4
