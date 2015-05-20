From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 May 2015 16:18:59 +0200
Subject: [PATCH 4/5] ARM64: MediaTek: Add generic pm domain support
In-Reply-To: <1432131540-2523-1-git-send-email-s.hauer@pengutronix.de>
References: <1432131540-2523-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1432131540-2523-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for generic power domains in the config.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7796af4..ba8469c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -185,6 +185,7 @@ config ARCH_MEDIATEK
 	bool "Mediatek MT65xx & MT81xx ARMv8 SoC"
 	select ARM_GIC
 	select PINCTRL
+	select PM_GENERIC_DOMAINS if PM
 	help
 	  Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
 
-- 
2.1.4
