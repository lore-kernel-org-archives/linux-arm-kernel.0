From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue,  4 Oct 2016 17:08:24 +0200
Subject: [RFC 06/10] ARM64: meson: enable MESON_IRQ_GPIO in Kconfig
In-Reply-To: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
References: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1475593708-10526-7-git-send-email-jbrunet@baylibre.com>
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
