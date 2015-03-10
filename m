From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Mar 2015 16:41:02 +0100
Subject: [PATCH 3/4] ARM64: MediaTek: Add generic pm domain support
In-Reply-To: <1426002063-25713-1-git-send-email-s.hauer@pengutronix.de>
References: <1426002063-25713-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1426002063-25713-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for generic power domains in the config.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b8e973..aef77d2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -174,6 +174,7 @@ config ARCH_FSL_LS2085A
 config ARCH_MEDIATEK
 	bool "Mediatek MT65xx & MT81xx ARMv8 SoC"
 	select ARM_GIC
+	select PM_GENERIC_DOMAINS if PM
 	help
 	  Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
 
-- 
2.1.4
